//**********************************************************************
// Input Generator implementation
//----------------------------------------------------------------------
//
//

package mkInputGen;

import H264Types::*;
import IInputGen::*;
import RegFile::*;
import FIFO::*;

import Connectable::*;
import GetPut::*;


module mkInputGen( IInputGen );

   RegFile#(Bit#(27), Bit#(8)) rfile <- mkRegFileLoad("inter_squid.hex", 0, 4376240);
   
   FIFO#(InputGenOT) outfifo <- mkFIFO;
   Reg#(Bit#(27))    index   <- mkReg(0);

   rule output_byte (index < 4376241);
      //$display( "ccl0inputbyte %x", rfile.sub(index) );
      outfifo.enq(DataByte rfile.sub(index));
      index <= index+1;
   endrule

   rule end_of_file (index == 4376241);
      //$finish(0);
      outfifo.enq(EndOfFile);
   endrule
   
   interface Get ioout = fifoToGet(outfifo);
   
endmodule


endpackage
