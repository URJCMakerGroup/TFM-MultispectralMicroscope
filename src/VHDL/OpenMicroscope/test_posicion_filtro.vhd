--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:42:24 07/06/2022
-- Design Name:   
-- Module Name:   C:/Users/david/Documents/2_OneDrive/OneDrive - Universidad Rey Juan Carlos/TFM/VHDL/OpenMicroscope/test_posicion_filtro.vhd
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
 
ENTITY test_posicion_filtro IS
END test_posicion_filtro;
 
ARCHITECTURE behavior OF test_posicion_filtro IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
   signal instruction : std_logic_vector(1 downto 0) := (others => '0');
   signal activate : std_logic := '0';
   signal final_stop_left : std_logic := '0';
   signal final_stop_right : std_logic := '0';

 	--Outputs
   signal ended : std_logic;
   signal motor_pulse : std_logic;
   signal motor_dir : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: m_posicionamiento_filtro PORT MAP (
          rst => rst,
          clk => clk,
          instruction => instruction,
          activate => activate,
          final_stop_left => final_stop_left,
          final_stop_right => final_stop_right,
          ended => ended,
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
		
      wait for clk_period*100;
		final_stop_left <= '1';
		instruction <="01";
		activate <= '1';
		wait for clk_period*5;
		activate <= '0';
		final_stop_left <= '0';
		wait for clk_period*100;
		wait for clk_period*100;

      -- insert stimulus here 

      wait;
   end process;

END;
