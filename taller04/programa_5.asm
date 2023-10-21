      SET R1, 0x00
      SET R2, 0x00
      SET R3, 0x01
loop: ADD R1, R0
      SUB R0, R3
      CMP R0, R2
      JZ halt
      JMP loop
halt: JMP halt
