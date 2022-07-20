--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:36:52 05/18/2022
-- Design Name:   
-- Module Name:   C:/Users/david/Documents/2_OneDrive/OneDrive - Universidad Rey Juan Carlos/TFM/VHDL/OpenMicroscope/test_top_microscopio.vhd
-- Project Name:  OpenMicroscope
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_microscopio
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
 
ENTITY test_top_microscopio IS
END test_top_microscopio;
 
ARCHITECTURE behavior OF test_top_microscopio IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_microscopio
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         uart_rx : IN  std_logic;
         uart_tx_data : OUT  std_logic;
         led_estado : OUT  std_logic_vector(2 downto 0);
         sw0_test_cmd : IN  std_logic;
         sw13_regs : IN  std_logic_vector(2 downto 0);
         sw57_rgbfilter : IN  std_logic_vector(2 downto 0);
         sw4_test_osc : IN  std_logic;
         btnr_test : IN  std_logic;
         btnl_oscop : IN  std_logic;
         btnc_resend : IN  std_logic;
         ov7670_sioc : OUT  std_logic;
         ov7670_siod : OUT  std_logic;
         ov7670_rst_n : OUT  std_logic;
         ov7670_pwdn : OUT  std_logic;
         ov7670_vsync : IN  std_logic;
         ov7670_href : IN  std_logic;
         ov7670_pclk : IN  std_logic;
         ov7670_xclk : OUT  std_logic;
         ov7670_d : IN  std_logic_vector(7 downto 0);
         vga_red : OUT  std_logic_vector(3 downto 0);
         vga_green : OUT  std_logic_vector(3 downto 0);
         vga_blue : OUT  std_logic_vector(3 downto 0);
         vga_hsync : OUT  std_logic;
         vga_vsync : OUT  std_logic;
         led : OUT  std_logic_vector(7 downto 0);
         anode7seg : OUT  std_logic_vector(7 downto 0);
         seg7 : OUT  std_logic_vector(6 downto 0);
         endstop1 : IN  std_logic;
         endstop2 : IN  std_logic;
         endstop3 : IN  std_logic;
         led_endstop1 : OUT  std_logic;
         led_endstop2 : OUT  std_logic;
         led_endstop3 : OUT  std_logic;
         sw_display : IN  std_logic;
         led_dir : OUT  std_logic;
         int1 : OUT  std_logic_vector(3 downto 0);
         int2 : OUT  std_logic_vector(3 downto 0);
         int3 : OUT  std_logic_vector(3 downto 0);
         filter_motor_pulse : OUT  std_logic;
         filter_motor_dir : OUT  std_logic;
         filter_stop_left : IN  std_logic;
         filter_stop_right : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic;
   signal clk : std_logic;
   signal uart_rx : std_logic;
   signal sw0_test_cmd : std_logic;
   signal sw13_regs : std_logic_vector(2 downto 0) := (others => '0');
   signal sw57_rgbfilter : std_logic_vector(2 downto 0) := (others => '0');
   signal sw4_test_osc : std_logic := '0';
   signal btnr_test : std_logic := '0';
   signal btnl_oscop : std_logic := '0';
   signal btnc_resend : std_logic := '0';
   signal ov7670_vsync : std_logic := '0';
   signal ov7670_href : std_logic := '0';
   signal ov7670_pclk : std_logic := '0';
   signal ov7670_d : std_logic_vector(7 downto 0) := (others => '0');
   signal endstop1 : std_logic := '0';
   signal endstop2 : std_logic := '0';
   signal endstop3 : std_logic := '0';
   signal sw_display : std_logic := '0';
   signal filter_stop_left : std_logic;
   signal filter_stop_right : std_logic := '0';

 	--Outputs
   signal uart_tx_data : std_logic;
   signal led_estado : std_logic_vector(2 downto 0);
   signal ov7670_sioc : std_logic;
   signal ov7670_siod : std_logic;
   signal ov7670_rst_n : std_logic;
   signal ov7670_pwdn : std_logic;
   signal ov7670_xclk : std_logic;
   signal vga_red : std_logic_vector(3 downto 0);
   signal vga_green : std_logic_vector(3 downto 0);
   signal vga_blue : std_logic_vector(3 downto 0);
   signal vga_hsync : std_logic;
   signal vga_vsync : std_logic;
   signal led : std_logic_vector(7 downto 0);
   signal anode7seg : std_logic_vector(7 downto 0);
   signal seg7 : std_logic_vector(6 downto 0);
   signal led_endstop1 : std_logic;
   signal led_endstop2 : std_logic;
   signal led_endstop3 : std_logic;
   signal led_dir : std_logic;
   signal int1 : std_logic_vector(3 downto 0);
   signal int2 : std_logic_vector(3 downto 0);
   signal int3 : std_logic_vector(3 downto 0);
   signal filter_motor_pulse : std_logic;
   signal filter_motor_dir : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant ov7670_pclk_period : time := 10 ns;
   constant ov7670_xclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_microscopio PORT MAP (
          rst => rst,
          clk => clk,
          uart_rx => uart_rx,
          uart_tx_data => uart_tx_data,
          led_estado => led_estado,
          sw0_test_cmd => sw0_test_cmd,
          sw13_regs => sw13_regs,
          sw57_rgbfilter => sw57_rgbfilter,
          sw4_test_osc => sw4_test_osc,
          btnr_test => btnr_test,
          btnl_oscop => btnl_oscop,
          btnc_resend => btnc_resend,
          ov7670_sioc => ov7670_sioc,
          ov7670_siod => ov7670_siod,
          ov7670_rst_n => ov7670_rst_n,
          ov7670_pwdn => ov7670_pwdn,
          ov7670_vsync => ov7670_vsync,
          ov7670_href => ov7670_href,
          ov7670_pclk => ov7670_pclk,
          ov7670_xclk => ov7670_xclk,
          ov7670_d => ov7670_d,
          vga_red => vga_red,
          vga_green => vga_green,
          vga_blue => vga_blue,
          vga_hsync => vga_hsync,
          vga_vsync => vga_vsync,
          led => led,
          anode7seg => anode7seg,
          seg7 => seg7,
          endstop1 => endstop1,
          endstop2 => endstop2,
          endstop3 => endstop3,
          led_endstop1 => led_endstop1,
          led_endstop2 => led_endstop2,
          led_endstop3 => led_endstop3,
          sw_display => sw_display,
          led_dir => led_dir,
          int1 => int1,
          int2 => int2,
          int3 => int3,
          filter_motor_pulse => filter_motor_pulse,
          filter_motor_dir => filter_motor_dir,
          filter_stop_left => filter_stop_left,
          filter_stop_right => filter_stop_right
        );
	-- Instantiate the Unit Under Test (UUT)
   uut: m_posicionamiento_filtro PORT MAP (
         clk => clk,
			rst => rst,
			instruction => motor_filter_instruction, -- nueva position
			activate => motor_filter_activate, -- activar el motor
			ended => motor_filter_ended , -- proceso finalizado
			final_stop_left => filter_stop_left, -- final de carrera izquierdo
			final_stop_right => filter_stop_right , -- final de carrera derecho
			motor_pulse => filter_motor_pulse,
	      motor_dir => filter_motor_dir 
        );
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   ov7670_pclk_process :process
   begin
		ov7670_pclk <= '0';
		wait for ov7670_pclk_period/2;
		ov7670_pclk <= '1';
		wait for ov7670_pclk_period/2;
   end process;
 
   ov7670_xclk_process :process
   begin
		ov7670_xclk <= '0';
		wait for ov7670_xclk_period/2;
		ov7670_xclk <= '1';
		wait for ov7670_xclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '1';
      wait for 95 ns;	
		rst <= '0';
		wait for clk_period*10;
		uart_rx <= "01000010";
      wait for clk_period*10000;
		filter_stop_left <= '1';
		wait for clk_period*10000;
		uart_rx <= "01000010";
      -- insert stimulus here 

      wait;
   end process;

END;
