--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:32:33 05/11/2022
-- Design Name:   
-- Module Name:   C:/Users/david/Documents/2_OneDrive/OneDrive - Universidad Rey Juan Carlos/TFM/VHDL/OpenMicroscope/test_posFiltro_ME.vhd
-- Project Name:  OpenMicroscope
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: m_posicionamiento_filtro
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_posFiltro_ME IS
END test_posFiltro_ME;
 
ARCHITECTURE behavior OF test_posFiltro_ME IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	 COMPONENT proc_serie
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         dat_ready : IN  std_logic;
         uart_data : IN  std_logic_vector(7 downto 0);
         led_estado : OUT  std_logic_vector(2 downto 0);
         s_e_ajuste : IN  std_logic;
         i_motor_m1 : OUT  std_logic;
         i_motor_m2 : OUT  std_logic;
         i_motor_m3 : OUT  std_logic;
         s_funciona_m1 : IN  std_logic;
         s_funciona_m2 : IN  std_logic;
         s_funciona_m3 : IN  std_logic;
         c_rev_abs_m1 : OUT  std_logic_vector(3 downto 0);
         c_rev_abs_m2 : OUT  std_logic_vector(3 downto 0);
         c_rev_abs_m3 : OUT  std_logic_vector(3 downto 0);
         i_dir : OUT  std_logic;
         pos_maximo : IN  std_logic_vector(3 downto 0);
         aux_sobel_h : OUT  std_logic;
         ram_reseteada : IN  std_logic;
         s_reset_ram : OUT  std_logic;
         fin_manda_img : IN  std_logic;
         i_cap_img : OUT  std_logic;
         inic_sum : OUT  std_logic; 
         i_manda_img : OUT  std_logic;
         i_motor_filter_instruction : OUT  std_logic_vector(1 downto 0);
         i_motor_filter_activate : OUT  std_logic;
         i_motor_filter_ended : IN  std_logic
        );
    END COMPONENT;
 
    COMPONENT m_posicionamiento_filtro
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         instruction : IN  std_logic_vector(1 downto 0);
         activate : IN  std_logic;
         final_stop_left : IN  std_logic;
         final_stop_right : IN  std_logic;
         ended : OUT  std_logic;
         motor_pulse : OUT  std_logic;
         motor_dir : OUT  std_logic
        );
    END COMPONENT;
    

	   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal dat_ready : std_logic := '0';
   signal uart_data : std_logic_vector(7 downto 0) := (others => '0');
   signal s_e_ajuste : std_logic := '0';
   signal s_funciona_m1 : std_logic := '0';
   signal s_funciona_m2 : std_logic := '0';
   signal s_funciona_m3 : std_logic := '0';
   signal pos_maximo : std_logic_vector(3 downto 0) := (others => '0');
   signal ram_reseteada : std_logic := '0';
   signal fin_manda_img : std_logic := '0';
   signal i_motor_filter_ended : std_logic := '0';

 	--Outputs
   signal led_estado : std_logic_vector(2 downto 0);
   signal i_motor_m1 : std_logic;
   signal i_motor_m2 : std_logic;
   signal i_motor_m3 : std_logic;
   signal c_rev_abs_m1 : std_logic_vector(3 downto 0);
   signal c_rev_abs_m2 : std_logic_vector(3 downto 0);
   signal c_rev_abs_m3 : std_logic_vector(3 downto 0);
   signal i_dir : std_logic;
   signal aux_sobel_h : std_logic;
   signal s_reset_ram : std_logic;
   signal i_cap_img : std_logic;
   signal inic_sum : std_logic;
   signal i_manda_img : std_logic;
   signal i_motor_filter_instruction : std_logic_vector(1 downto 0);
   signal i_motor_filter_activate : std_logic;

   --Inputs
   --signal instruction : std_logic_vector(1 downto 0) := (others => '0');
   --signal activate : std_logic := '0';
   signal final_stop_left : std_logic := '0';
   signal final_stop_right : std_logic := '0';

 	--Outputs
   signal ended : std_logic;
   signal motor_pulse : std_logic;
   signal motor_dir : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	uutMain: proc_serie PORT MAP (
          rst => rst,
          clk => clk,
          dat_ready => dat_ready,
          uart_data => uart_data,
          led_estado => led_estado,
          s_e_ajuste => s_e_ajuste,
          i_motor_m1 => i_motor_m1,
          i_motor_m2 => i_motor_m2,
          i_motor_m3 => i_motor_m3,
          s_funciona_m1 => s_funciona_m1,
          s_funciona_m2 => s_funciona_m2,
          s_funciona_m3 => s_funciona_m3,
          c_rev_abs_m1 => c_rev_abs_m1,
          c_rev_abs_m2 => c_rev_abs_m2,
          c_rev_abs_m3 => c_rev_abs_m3,
          i_dir => i_dir,
          pos_maximo => pos_maximo,
          aux_sobel_h => aux_sobel_h,
          ram_reseteada => ram_reseteada,
          s_reset_ram => s_reset_ram,
          fin_manda_img => fin_manda_img,
          i_cap_img => i_cap_img,
          inic_sum => inic_sum,
          i_manda_img => i_manda_img,
          i_motor_filter_instruction => i_motor_filter_instruction,
          i_motor_filter_activate => i_motor_filter_activate,
          i_motor_filter_ended => i_motor_filter_ended
        );
		  
	-- Instantiate the Unit Under Test (UUT)
   uut: m_posicionamiento_filtro PORT MAP (
          rst => rst,
          clk => clk,
          instruction => i_motor_filter_instruction,
          activate => i_motor_filter_activate,
          final_stop_left => final_stop_left,
          final_stop_right => final_stop_right,
          ended => i_motor_filter_ended,
          motor_pulse => motor_pulse,
          motor_dir => motor_dir
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 95 ns;	
		rst <= '0';
		wait for clk_period*1000;
		final_stop_left <='1';
		wait for clk_period*100000;
		dat_ready <= '1';
		uart_data <= "01000001"; --65
		wait for clk_period;
		dat_ready <= '0';
		wait for clk_period*100;
		final_stop_left <='0';
		--wait for clk_period*100000;
		--dat_ready <= '1';
		--uart_data <= "01000010"; --66
		--wait for clk_period;
		--dat_ready <= '0';
		
		--wait for clk_period*850000;
		--wait for clk_period*10000000;
		--dat_ready <= '1';
		--uart_data <= "01000011"; --67
		--wait for clk_period;
		--dat_ready <= '0';
		
		--wait for clk_period*10000000;
		--dat_ready <= '1';
		--uart_data <= "01000000"; --64
		--wait for clk_period;
		--dat_ready <= '0';
		
		--wait for clk_period*10000000;
		--wait for clk_period*10000000;
		--dat_ready <= '1';
		--uart_data <= "01000000"; --64
		--wait for clk_period;
		--dat_ready <= '0';
		
      wait;
   end process;

END;
