```diff
-Lab- 8 (Baláž 222727)
```


## Preparation tasks (done before the lab at home)
| **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Clock** | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![zrising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) | ![rising](Images/sipka_hore.png) |
| **State** | A | A | B | C | C | D | A | B | C | D | B | B | B | C | D | B |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `1` | `0` |


| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |
## Nexys A7-50T
![Nexys](Images/n4r.png)
## Traffic light controller 
![Schema](Images/schema.jpg)

## p_traffic_fsm process (VHDL source)

```vhdl
    p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>
                         -- Count up to c_DELAY_GO
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                   when WEST_WAIT =>
                       -- Count up to c_DELAY_WAIT
                    if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP2;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when STOP2 =>
                       -- Count up to c_DELAY_1SEC
                    if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    
                     when SOUTH_GO =>
                       -- Count up to c_DELAY_GO
                    if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;    
                        
                     when SOUTH_WAIT =>
                       -- Count up to c_DELAY_WAIT
                    if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP1;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;    
                        
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;

```

## p_output_fsm process (VHDL source)

```vhdl
---------------------------------
       --RGB = 100 -> Červená
       --RGB = 010 -> Zelená
       --RGB = 110 -> Žltá  
---------------------------------
    p_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                south_o <= "100";  -- červená 
                west_o  <= "100";  -- červená 
                
            when WEST_GO =>
                south_o <= "100";  -- červená   
                west_o  <= "010";  -- zelená
                
            when WEST_WAIT =>
                south_o <= "100";  -- červená 
                west_o  <= "110";  -- žltá  
                
            when STOP2 =>
                south_o <= "100";  -- červená  
                west_o  <= "100";  -- červená   
                
            when SOUTH_GO =>
                south_o <= "010";  -- zelená   
                west_o  <= "100";  -- červená 
            
            when SOUTH_WAIT =>
                south_o <= "110";   -- žltá  
                west_o  <= "100";   -- červená 

            when others =>
                south_o <= "100";   -- červená 
                west_o  <= "100";   -- červená 
        end case;
    end process p_output_fsm;

end architecture Behavioral;
```
## Simulation 
![simulacia](Images/simulacia.PNG)
## Table for smart controller

| **Current state** | **Direction South** | **Direction West** | **Delay** | Info |
| :-- | :-: | :-: | :-: | :-: |
| `STOP1`      | red    | red | 1 sec | --- |
| `WEST_GO`    | red    | green | 4 sec | Má senzor |
| `WEST_WAIT`  | red    | yellow | 2 sec | --- |
| `STOP2`      | red    | red | 1 sec | --- |
| `SOUTH_GO`   | green  | red | 4 sec | Má senzor |
| `SOUTH_WAIT` | yellow | red | 2 sec | --- |
## Smart Controller 
![Simulacia](Images/smart.jpg)
## p_smart_traffic_fsm (VHDL source)
```vhdl
   p_smart_traffic_fsm : process(clk)
    begin
            if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>
                         -- Count up to c_DELAY_GO
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                        if (south_sensor = '0' and west_sensor = '1') then  
                            s_state <= WEST_GO;
                            else
                            -- Move to the next state
                            s_state <= WEST_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        end if;
                        
                   when WEST_WAIT =>
                       -- Count up to c_DELAY_WAIT
                    if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP2;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when STOP2 =>
                       -- Count up to c_DELAY_1SEC
                    if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    
                     when SOUTH_GO =>
                       -- Count up to c_DELAY_GO
                    if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                           if (south_sensor = '1' and west_sensor = '0') then  
                            s_state <= SOUTH_GO;
                            else
                            -- Move to the next state
                            s_state <= SOUTH_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;    
                        end if;
                        
                     when SOUTH_WAIT =>
                       -- Count up to c_DELAY_WAIT
                    if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP1;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;    
                        
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_smart_traffic_fsm;
```