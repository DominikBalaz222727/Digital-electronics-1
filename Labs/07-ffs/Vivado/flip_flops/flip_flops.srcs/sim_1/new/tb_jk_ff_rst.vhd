----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2021 08:46:16
-- Design Name: 
-- Module Name: tb_jk_ff_rst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_jk_ff_rst is
--  Port ( );
end tb_jk_ff_rst;

architecture Behavioral of tb_jk_ff_rst is

 -- Local constants
     constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
     -- Local signals
     signal s_clk   :  STD_LOGIC;  
     signal s_j     :  STD_LOGIC;  
     signal s_k     :  STD_LOGIC;  
     signal s_rst   :  STD_LOGIC;  
     signal s_q     :  STD_LOGIC; 
     signal s_q_bar :  STD_LOGIC;

  begin
     uut_jk_ff_rst : entity work.jk_ff_rst
      port map (
         clk       => s_clk,
         j         => s_j,
         k         => s_k,
         rst       => s_rst,
         q         => s_q,
         q_bar     => s_q_bar
);

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    
      p_clk_gen : process
      begin 
         while now < 750ns loop         -- 75 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
      end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
      p_reset_gen : process
      begin
           s_rst <= '0';
           wait for 328 ns;
        
        -- Reset activated
           s_rst <= '1';
           wait for 144 ns;

        -- Reset deactivated
           s_rst <= '0';

           wait;
       end process p_reset_gen;
    
      p_jk_ff_rst :process
      begin
          report "Stimulus process started" severity note;
          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
          
          s_j    <= '1'; 
          s_k    <= '0';
          wait for 14 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 24 ns;
          s_j    <= '0';
          s_k    <= '1';
          wait for 22 ns;
          s_j    <= '1';
          s_k    <= '1';
          wait for 36 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
          
          s_j    <= '1'; 
          s_k    <= '0';
          wait for 14 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 24 ns;
          s_j    <= '0';
          s_k    <= '1';
          wait for 22 ns;
          s_j    <= '1';
          s_k    <= '1';
          wait for 36 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
          
          s_j    <= '1'; 
          s_k    <= '0';
          wait for 14 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 24 ns;
          s_j    <= '0';
          s_k    <= '1';
          wait for 22 ns;
          s_j    <= '1';
          s_k    <= '1';
          wait for 36 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
          
          s_j    <= '1'; 
          s_k    <= '0';
          wait for 14 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 24 ns;
          s_j    <= '0';
          s_k    <= '1';
          wait for 22 ns;
          s_j    <= '1';
          s_k    <= '1';
          wait for 36 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
         
          report "Stimulus process finished" severity note;
          wait;

        end process p_jk_ff_rst;
end Behavioral;