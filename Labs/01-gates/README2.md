EDA PLAYGROUND ODKAZ
https://www.edaplayground.com/x/gujC

```vhdl
architecture dataflow of gates is
begin
    f_o      <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    fnand_o <= not (not (not b_i and a_i) and not(not c_i and not b_i));
    fnor_o  <= not(b_i or not a_i) or not (c_i or b_i);
end architecture dataflow;
```

DISTRIBUCNE 
https://www.edaplayground.com/x/kuqx