\TLV calc()
   
   
   |calc
      @1
         
         $val2[7:0] = {4'b0, *ui_in[3:0]};
         $op[1:0] = *ui_in[5:4];
         $equals_in = *ui_in[7];
      //@1
         $val1[7:0] = >>1$out[7:0];
         $sum[7:0] = $val1[7:0] + $val2[7:0];
         $diff[7:0] = $val1[7:0] - $val2[7:0];
         $mul[7:0] = $val1[7:0] * $val2[7:0];
         $div[7:0] = $val1[7:0] / $val2[7:0];
         $valid = $equals_in && !(>>1$equals_in);
         $out[7:0] = $reset
                        ? 8'b0 :
                     !($valid)
                        ? >>1$out[7:0] :
                     $op[1:0] == 2'b00
                        ? $sum[7:0] :
                     $op[1:0] == 2'b01
                        ? $diff[7:0] :
                     $op[1:0] == 2'b10
                        ? $mul[7:0] :
                     $div[7:0];
         
         $digit[3:0] = $out[3:0];
         *uo_out[7:0] = $digit[3:0] == 4'b0000
             ? 8'b00111111 :
             $digit[3:0] == 4'b0001
             ? 8'b00000110 :
             $digit[3:0] == 4'b0010
             ? 8'b01011011 :
             $digit[3:0] == 4'b0011
             ? 8'b01001111 :
             $digit[3:0] == 4'b0100
             ? 8'b01100110 :
             $digit[3:0] == 4'b0101
             ? 8'b01101101 :
             $digit[3:0] == 4'b0110
             ? 8'b01111101 :
             $digit[3:0] == 4'b0111
             ? 8'b00000111 :
             $digit[3:0] == 4'b1000
             ? 8'b01111111 :
             $digit[3:0] == 4'b1001
             ? 8'b01101111 :
             $digit[3:0] == 4'b1010
             ? 8'b01110111 :
             $digit[3:0] == 4'b1011
             ? 8'b01111100 :
             $digit[3:0] == 4'b1100
             ? 8'b00111001 :
             $digit[3:0] == 4'b1101
             ? 8'b01011110 :
             $digit[3:0] == 4'b1110
             ? 8'b01111001 : 8'b01110001 ;
      
   // Note that pipesignals assigned here can be found under /fpga_pins/fpga.
   
   

   m5+cal_viz(@1, m5_if(m5_in_fpga, /fpga, /top))
   
   // Connect Tiny Tapeout outputs. Note that uio_ outputs are not available in the Tiny-Tapeout-3-based FPGA boards.
   
   m5_if_neq(m5_target, FPGA, ['*uio_out = 8'b0;'])
   m5_if_neq(m5_target, FPGA, ['*uio_oe = 8'b0;'])

