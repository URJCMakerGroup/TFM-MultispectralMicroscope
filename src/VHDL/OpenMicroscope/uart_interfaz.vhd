library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.all;

library work;
use work.ov7670_pkg.all;

entity uart_interfaz is
    Port ( 
           rst           : in  std_logic;
           clk           : in  std_logic;
           TxOcupado     : in  std_logic;
           frame_pxl     : in  std_logic_vector(8-1 downto 0); 
           
           s_env_af : in std_logic;
           
           s_env_img     : in  std_logic;
           env_pxl       : out  std_logic;
           fin_manda_img : out std_logic;
           
            
           Transmite     : out  std_logic;        
           Caracter      : out  std_logic_vector(8-1 downto 0);
           frame_addr    : out  std_logic_vector(c_nb_img_pxls-1 downto 0)
           ); 
           
end uart_interfaz;

architecture Behavioral of uart_interfaz is

  signal   pb_up_reg     : std_logic;
  signal   pb_up_reg2    : std_logic;
  signal   pulso_up      : std_logic;
  signal   en_uart       : std_logic;
    
  constant fin_cuenta_pxl: natural := 76800; --320x240 
  signal   aux_transmite : std_logic;
  signal   fin_manda_img_aux : std_logic;
  signal   aux : std_logic;
  signal   addr          : std_logic_vector(c_nb_img_pxls-1 downto 0);
  
begin


RegPB:Process(rst, Clk)
begin
    if rst = '1' then
      pb_up_reg     <= '0';
      pb_up_reg2    <= '0';
    elsif Clk'event and Clk= '1' then
      pb_up_reg     <= s_env_img;
      pb_up_reg2    <= pb_up_reg;    
    end if;
end process;    
pulso_up <= '1' when (pb_up_reg='1' and pb_up_reg2='0') else '0'; 



bies_T_btn : process(rst, clk)
    begin
        if rst='1' then
            en_uart <= '0';
            fin_manda_img_aux <= '0';
        elsif clk' event and clk='1' then
            if pulso_up = '1' or s_env_af = '1' then  
               en_uart <= '1';
               fin_manda_img_aux <= '0'; 
            elsif addr = fin_cuenta_pxl then                
               en_uart <= '0';      
               fin_manda_img_aux <= '1'; 
            else      
               en_uart <= en_uart;   
               fin_manda_img_aux <= '0';
            end if;
        end if;
end process;     
env_pxl <= en_uart;
Caracter <= frame_pxl;
fin_manda_img <= fin_manda_img_aux;
 
Interfaz:Process(rst, Clk)
  begin
    if rst = '1' then
      addr <= (others=>'0');
    elsif Clk'event and Clk='1' then
      if en_uart = '1' then 
      
         if  TxOcupado = '0' then
            if aux_transmite = '1' then 
               addr <= addr + 1;       
            else
               addr <= addr;
            end if;
         end if;  
      else
         addr <= (others=>'0');  
      end if;
    end if;
  end process;
   
   
Caracter <= frame_pxl;
aux_transmite <= '1' when TxOcupado = '0' and en_uart = '1' else '0';
Transmite <= aux_transmite;
frame_addr <= addr;
 
end Behavioral;
