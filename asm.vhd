----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/01/2025 10:01:50 PM
-- Design Name: 
-- Module Name: asm - Behavioral
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

entity asm is
  Port ( 
        clk, x, reset: in std_logic;
        z: out std_logic_vector(2 downto 1);
        s: out std_logic_vector(6 downto 0)
  );
end asm;

architecture Behavioral of asm is
type sreg is (idle,s1,s2,s3,s4,s5,s6);
signal present_state, next_state: sreg:= idle; --initial state idle
begin
    statem: process
    begin 
        wait until clk' event and clk ='0';             
                case present_state is 
                    when idle => 
                    s <= "0000001";
                        if x='0' then 
                            z <= "11";
                            next_state <= idle;
                        else
                            z <= "01";
                            next_state <= s2;
                        end if;
                    when s1 => 
                    s <= "0000010";
                        if x='0' then 
                            z <= "01";
                            next_state <= idle;
                        else
                            z <= "11";
                            next_state <= s3;
                        end if;
                    when s2 => 
                    s <= "0000100";
                        if x='0' then 
                            z <= "00";
                            next_state <= s5;
                        else
                            z <= "10";
                            next_state <= s1;
                        end if;
                    when s3 => 
                    s <= "0001000";
                        if x='0' then 
                            z <= "00";
                            next_state <= s2;
                        else
                            z <= "10";
                            next_state <= s4;
                        end if;     
                    when s4 => 
                     s <= "0010000";
                        if x='0' then 
                            z <= "11";
                            next_state <= s1;                          
                        else
                            z <= "01";
                            next_state <= s6;
                        end if;    
                    when s5 => 
                    s <= "0100000";
                        if x='0' then 
                            z <= "11";
                            next_state <= s4;
                        else
                            z <= "00";
                            next_state <= s5;
                        end if;    
                    when s6 => 
                    s <= "1000000";
                        if x='0' then 
                            z <= "11";
                            next_state <= idle;
                        else
                            z <= "01";
                            next_state <= s2;
                        end if;      
                    when others => 
                        z <= "00";
                        next_state <= idle;
                    end case;
    end process statem;

clk_process: process
	begin
	wait until clk' event and clk = '1'; --wait until the rising edge
	if reset = '0' then
	   present_state <= idle;
	else 
	   present_state <= next_state;
    end if;
end process clk_process;

end Behavioral;
