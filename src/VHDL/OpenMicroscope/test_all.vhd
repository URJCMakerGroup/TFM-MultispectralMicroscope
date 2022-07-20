--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:13:06 05/21/2022
-- Design Name:   
-- Module Name:   C:/Users/david/Documents/2_OneDrive/OneDrive - Universidad Rey Juan Carlos/TFM/VHDL/OpenMicroscope/test_all.vhd
-- Project Name:  OpenMicroscope
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_uart_rx
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
 
ENTITY test_all IS
END test_all;
 
ARCHITECTURE behavior OF test_all IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_uart_rx
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         uart_rx : IN  std_logic;
         led_estado : OUT  std_logic_vector(2 downto 0);
         s_e_ajuste : IN  std_logic;
         s_funciona_m1 : IN  std_logic;
         s_funciona_m2 : IN  std_logic;
         s_funciona_m3 : IN  std_logic;
         i_motor_m1 : OUT  std_logic;
         i_motor_m2 : OUT  std_logic;
         i_motor_m3 : OUT  std_logic;
         i_dir : OUT  std_logic;
         c_rev_abs_m1 : OUT  std_logic_vector(3 downto 0);
         c_rev_abs_m2 : OUT  std_logic_vector(3 downto 0);
         c_rev_abs_m3 : OUT  std_logic_vector(3 downto 0);
         pos_maximo : IN  std_logic_vector(3 downto 0);
         ram_reseteada : IN  std_logic;
         s_reset_ram : OUT  std_logic;
         s_env_af : IN  std_logic;
         fin_manda_img : IN  std_logic;
         aux_sobel_h : OUT  std_logic;
         i_cap_img : OUT  std_logic;
         inic_sum : OUT  std_logic;
         i_manda_img : OUT  std_logic;
         motor_filter_instruction : OUT  std_logic_vector(1 downto 0);
         motor_filter_activate : OUT  std_logic;
         motor_filter_ended : IN  std_logic
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
   signal uart_rx : std_logic := '1';
   signal s_e_ajuste : std_logic := '0';
   signal s_funciona_m1 : std_logic := '0';
   signal s_funciona_m2 : std_logic := '0';
   signal s_funciona_m3 : std_logic := '0';
   signal pos_maximo : std_logic_vector(3 downto 0) := (others => '0');
   signal ram_reseteada : std_logic := '0';
   signal s_env_af : std_logic := '0';
   signal fin_manda_img : std_logic := '0';
   signal motor_filter_ended : std_logic := '0';

 	--Outputs
   signal led_estado : std_logic_vector(2 downto 0);
   signal i_motor_m1 : std_logic;
   signal i_motor_m2 : std_logic;
   signal i_motor_m3 : std_logic;
   signal i_dir : std_logic;
   signal c_rev_abs_m1 : std_logic_vector(3 downto 0);
   signal c_rev_abs_m2 : std_logic_vector(3 downto 0);
   signal c_rev_abs_m3 : std_logic_vector(3 downto 0);
   signal s_reset_ram : std_logic;
   signal aux_sobel_h : std_logic;
   signal i_cap_img : std_logic;
   signal inic_sum : std_logic;
   signal i_manda_img : std_logic;
   signal motor_filter_instruction : std_logic_vector(1 downto 0);
   signal motor_filter_activate : std_logic;

	signal final_stop_left : std_logic := '0';
   signal final_stop_right : std_logic := '0';

 	--Outputs
   signal motor_pulse : std_logic;
   signal motor_dir : std_logic;
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	-- baud rate: 9600
   constant baud_period : time := 8680 ns;  -- 868*10-6s
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_uart_rx PORT MAP (
          rst => rst,
          clk => clk,
          uart_rx => uart_rx,
          led_estado => led_estado,
          s_e_ajuste => s_e_ajuste,
          s_funciona_m1 => s_funciona_m1,
          s_funciona_m2 => s_funciona_m2,
          s_funciona_m3 => s_funciona_m3,
          i_motor_m1 => i_motor_m1,
          i_motor_m2 => i_motor_m2,
          i_motor_m3 => i_motor_m3,
          i_dir => i_dir,
          c_rev_abs_m1 => c_rev_abs_m1,
          c_rev_abs_m2 => c_rev_abs_m2,
          c_rev_abs_m3 => c_rev_abs_m3,
          pos_maximo => pos_maximo,
          ram_reseteada => ram_reseteada,
          s_reset_ram => s_reset_ram,
          s_env_af => s_env_af,
          fin_manda_img => fin_manda_img,
          aux_sobel_h => aux_sobel_h,
          i_cap_img => i_cap_img,
          inic_sum => inic_sum,
          i_manda_img => i_manda_img,
          motor_filter_instruction => motor_filter_instruction,
          motor_filter_activate => motor_filter_activate,
          motor_filter_ended => motor_filter_ended
        );

	uut_pos: m_posicionamiento_filtro PORT MAP (
          rst => rst,
          clk => clk,
          instruction => motor_filter_instruction,
          activate => motor_filter_activate,
          final_stop_left => final_stop_left,
          final_stop_right => final_stop_right,
          ended => motor_filter_ended,
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
      rst <= '1';
      wait for 95 ns;	
		rst <= '0';
		wait for clk_period*5000000;
		final_stop_left <='1';
		wait for clk_period*100000;
		uart_rx <= '0'; -- bit init 01000011
		wait for baud_period;
		uart_rx <= '1'; -- bit0
		wait for baud_period;
		uart_rx <= '1'; -- bit1
		wait for baud_period;
		uart_rx <= '0'; -- bit2
		wait for baud_period;
		uart_rx <= '0'; -- bit3
		wait for baud_period;
		uart_rx <= '0'; -- bit4
		wait for baud_period;
		uart_rx <= '0'; -- bit5
		wait for baud_period;
		uart_rx <= '1'; -- bit6
		wait for baud_period;
		uart_rx <= '0'; -- bit7
		wait for baud_period;
		uart_rx <= '1'; -- bit end
		wait for clk_period*5;
		
		--uart_rx <= "01000001";
		wait for clk_period*100;
		final_stop_left <='0';
		wait for clk_period*100000;
		-- uart_rx <= "00000100";
		wait for clk_period*100;
		-- uart_rx <= "00000001";
      -- insert stimulus here 

      wait;
   end process;

END;
