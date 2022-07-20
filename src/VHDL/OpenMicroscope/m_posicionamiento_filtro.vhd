----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:13:51 04/27/2022 
-- Design Name: 
-- Module Name:    m_posicionamiento_filtro - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity m_posicionamiento_filtro is
	port (
	rst : in std_logic; 
   clk : in std_logic;
	 
	instruction : in std_logic_vector(1 downto 0);
	activate : in std_logic;
	final_stop_left : in std_logic;
	final_stop_right : in std_logic;
	
	ended : out std_logic;
	motor_pulse : out std_logic;
	motor_dir : out std_logic
	);
	 
end m_posicionamiento_filtro;

architecture Behavioral of m_posicionamiento_filtro is

	signal posicion : std_logic_vector(1 downto 0);
	signal actual_pos: std_logic_vector(1 downto 0);
	
	signal cuenta_motor : unsigned (12 downto 0);
	signal ta : unsigned (12 downto 0);
	signal dir_derecha : std_logic;
	
	signal cuenta: unsigned (17-1 downto 0);
	constant fin_cuenta: natural := 100000; -- 2000000;-- 20ms --100000 -- 1ms;
	signal pulse: std_logic;
	signal aux_pulse: std_logic;
	signal Inicializando : std_logic;
	signal aux_motor_pulse : std_logic;
	
	
begin

-----------------------------------------------------------
-- Maquina de estados para cambiar de posicion
ME_posiciones : process(actual_pos, posicion,Inicializando)
	begin
	if Inicializando = '1' then
		ta <= "1111111111111"; -- infinitos pasos hasta toparse
		dir_derecha <= '0';
	else
		if actual_pos /= posicion then
			case actual_pos is 
				when "00" => -- Partir de posicion inicial
					case posicion is
						when "01" => -- Ir al primer filtro
							ta <= to_unsigned(2560,13); -- 1280 pasos
							dir_derecha <= '1';
						when "10" => -- Ir al segundo filtro
							ta <= to_unsigned(5120,13); -- 2560 pasos
							dir_derecha <= '1';
						when "11" => -- Ir al tercer filtro
							ta <= to_unsigned(7680,13); -- 3840 pasos
							dir_derecha <= '1';
						when others => -- Quieto
							ta <= to_unsigned(0,13);
							dir_derecha <= '0';
					end case;
				when "01" => -- Partir del primer filtro
					case posicion is
						when "00" => -- Ir a la posicion inicial
							ta <= to_unsigned(2560,13); -- 1280 pasos
							dir_derecha <= '0';
						when "10" => -- Ir al segundo filtro
							ta <= to_unsigned(2560,13); -- 1280 pasos
							dir_derecha <= '1';
						when "11" => -- Ir al tercer filtro
							ta <= to_unsigned(5120,13);  -- 2560 pasos
							dir_derecha <= '1';
						when others => -- Quieto
							ta <= to_unsigned(0,13); 
							dir_derecha <= '0';
					end case;
				when "10" => -- Partir del segundo filtro
					case posicion is
						when "00" => -- Ir a la posicion inicial
							ta <= to_unsigned(5120,13);  -- 2560 pasos
							dir_derecha <= '0';
						when "01" => -- Ir al primer filtro
							ta <= to_unsigned(1280,13); -- 1280 pasos
							dir_derecha <= '0';
						when "11" => -- Ir al tercer filtro
							ta <= to_unsigned(2560,13);  -- 1280 pasos
							dir_derecha <= '1';
						when others => -- Quieto
							ta <= to_unsigned(0,13); 
							dir_derecha <= '0';
					end case;
				when "11" => -- Partir del tercer filtro
					case posicion is
						when "00" => -- Ir a la posicion inicial
							ta <= to_unsigned(7680,13);  -- 3840 pasos
							dir_derecha <= '0';
						when "01" => -- Ir al primer filtro
							ta <= to_unsigned(5120,13);  -- 2560 pasos
							dir_derecha <= '0';
						when "10" => -- Ir al segundo filtro
							ta <= to_unsigned(2560,13);  -- 1280 pasos
							dir_derecha <= '0';
						when others => -- Quieto
							ta <= to_unsigned(0,13); 
							dir_derecha <= '0';
					end case;
				when others => -- Volver a la posicion del filtro original
					ta <= to_unsigned(0,13); 
					dir_derecha <= '1';
			end case;
			end if;
		end if;
	end process;
motor_dir <= dir_derecha;

-----------------------------------------------------------
-- Biestable para almacenar el filtro al que debe ir
biest_posicion : process(rst, clk)
    begin
        if rst='1' then
            posicion <="00";
        elsif clk' event and clk='1' then
				if Inicializando = '0' then
					if activate = '1' then -- Llega nueva instruccion
						if actual_pos = posicion then
							posicion <= instruction ;
						end if;
					else -- Nuevo ciclo sin instruccion
						posicion <= posicion ;
					end if;
				end if;
			end if;
    end process;  

----------------------------------------------------------------
-- Proceso de inicio del sistema de filtro
Inicializar : process (clk, rst)
 begin
	if rst = '1' then
		Inicializando <= '1';
	elsif clk' event and clk='1' then
		if final_stop_left = '1' then
			Inicializando <= '0';
		end if;
	end if;
end process;
----------------------------------------------------------------
-- Contador 1ms para activar pulso
Contador : process (clk, rst)
    begin 
	  if rst = '1' then
			cuenta <= (others => '0');
			pulse <= '0';
			aux_pulse <= '0';
	  elsif clk' event and clk = '1' then
	      aux_pulse <= pulse;
			if cuenta = fin_cuenta-1 then
				cuenta <= (others => '0');
				pulse <= '1';
			else 
				cuenta <= cuenta + 1;
				pulse <= '0';
			end if;
	  end if;
 end process;
 
Proceso_pulso : process(clk, rst)
	begin
		if rst = '1' then
			aux_motor_pulse <= '0';
		elsif clk' event and clk = '1' then
			if pulse = '1' and actual_pos /= posicion then
				if (final_stop_left = '0' and dir_derecha = '0') or (final_stop_right = '0' and dir_derecha = '1') then
					aux_motor_pulse <= not aux_motor_pulse;
				-- else
					--aux_motor_pulse <= '0';
				end if;
			end if;
		end if;
	end process;
 motor_pulse <= aux_motor_pulse;
-----------------------------------------------------------
-- Proceso para mover el motor durante un tiempo ta
Proceso_mover_filtro : process(clk, rst)
	begin
	if rst = '1' then
		cuenta_motor <= (others =>'0');
		actual_pos <= "01";
		ended <= '0';
	elsif clk' event and clk = '1' then
		ended <= '0';
		if actual_pos = posicion then
		  cuenta_motor <= (others =>'0');
		  ended <= '1';
		elsif final_stop_left = '1' and dir_derecha = '0' then
		  actual_pos <= "00";
		  cuenta_motor <= (others =>'0');
		  ended <= '1';
	   elsif final_stop_right = '1' and dir_derecha = '1' then
		  actual_pos <= "11";
		  cuenta_motor <= (others =>'0');
		  ended <= '1';
		elsif pulse = '1' and aux_pulse = '0' then
		 -- Motor activo y finales de carrera desactivados
		  if cuenta_motor = ta-1 then  -- llegar a la posicion
			 cuenta_motor <= (others =>'0');
			 actual_pos <= posicion;
			 ended <= '1';
		  else
			 cuenta_motor <= cuenta_motor + 1;
		  end if;
		end if;
	 end if;
  end process;
-----------------------------------------------------------

end Behavioral;