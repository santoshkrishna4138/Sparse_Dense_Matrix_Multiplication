<h1>Column_wise_560</h1>
<p>This is the repository containing the necessary verilog files for column-wise implementation of sparse-dense matrix multiplication for the matrix dimension of 560 x 560. I have also assumed that the first matrix is a sparse matrix with the number of non zeroes of 8960 equally distributed along columns.</p>
<h3>Block diagram</h3>


<img src="https://user-images.githubusercontent.com/79155839/124373534-a1b0b780-dcb0-11eb-9d79-2a32a5dc8a50.png" alt="Block Diagram"/>

<h3>Description of the files </h3>
<ol>
 <li>topmod.v</li><p> This module is the top module for the entire design and is used as top for synthesis. This instantiates all the other modules involved in the design.</p>
 <li>matrix.v</li><p>This module consists of the code relating to the initialization of the sparse BRAMs with the sparse matrix at the start of the execution process.</p>
 <li>counter_up.v , counter_even.v , counter_odd.v</li><p>These are simple counter logics used within the design.</p>
 <li>adder_output.v</li><p>This module is the block responsible for reading from the 16 partial product storing BRAMs and summing them up and sending them out as final output matrix. The output is sent 2 values every cycle and each instance of adder_output.v is responsible for generating one output value every cycle.</p>
 <li>MUL_BLOCK.v</li><p>This module consists of a single instance of a multiplier IP and is responsible for giving it valid output and giving out valid outputs as and when the multiplier produces an output. </p>
 <li>ADDITION_BLOCK.v</li><p>This module is responsible for adding the newly generated partial product with the pre-existing partial product within the partial product BRAM.</p>
 <li>sr_flip.v</li><p> This module consists of simple single bit counters.</p>
 <li>simulation.v</li> <p>This module is the testbench used for the simulation of the design. It instantiates topmod.v and provides the inputs and collects the output from the design.</p>
</ol>

<h3>Xilinx IP Instantiation</h3> 
 <p>The sparse matrix is stored in the COO format.</p>
<p>Other than the files included in the repository, in order to run the code, the following Xilinx IPs will have to be instantiated with the settings for each described below.</p>
<ol>
 <li> Block Memory Generator:</li>
      <ul>
       <li>Memory Type: True Dual Port RAM</li>
       <li> Common Clock: Ticked</li>
       <li> Port A and Port B options:</li>
           <ul>
            <li>Write Width: 32</li>
            <li> Read Width: 32</li>
            <li> Write Depth: 2048</li>
            <li> Read Depth: 2048</li>
            <li> Enable Port Type: Use ENA/ENB pin</li>
       </ul>
 </ul>
<img src="https://user-images.githubusercontent.com/79155839/124355180-85b80200-dc2d-11eb-87bb-1dd471deec06.png" alt="Summary of changes to the instantiation of BRAM1"/>

 <li>Block Memory Generator:</li>
  <ul>
       <li>Memory Type: True Dual Port RAM</li>
       <li> Common Clock: Ticked</li>
       <li> Port A and Port B options:</li>
           <ul>
            <li>Write Width: 64</li>
            <li> Read Width: 64</li>
            <li> Write Depth:1024</li>
            <li> Read Depth: 1024</li>
            <li> Enable Port Type: Use ENA/ENB pin</li>
       </ul>
 </ul>
<img src="https://user-images.githubusercontent.com/79155839/124355486-0e836d80-dc2f-11eb-82ff-4f47f649f8e6.png" alt="Summary of changes to the instantiation of BRAM1"/>
 <li>Multiplier</li>
<ul>
       <li>Data Type: Signed</li>
       <li> Width: 32</li>
       <li> Multiplier Construction: Use Mults</li>
       <li>Optimization Options: Speed Optimized</li>
       <li> Multiplier Type: Parallel Multiplier</li>
       <li> Pipeline Stages: 6</li>
       <li> Synchronous Clear: Ticked </li>
          
 </ul>
 <img src="https://user-images.githubusercontent.com/79155839/124355675-1099fc00-dc30-11eb-8446-6e41faf1e4dd.png" alt="Instantiation of Multiplier IP"/>

 <li>Adder/Subtractor  First Instantiation</li> 

 <ul>
       <li>Input Type: Signed</li>
       <li> Input Width: 64</li>
       <li> Add Mode: Add</li>
       <li>Output Width: 64</li>
       <li> Latency Configuration: Manual</li>
       <li> Latency: 1</li>
       <li> Implement using : Fabric</li>
        
 </ul>
  <img src="https://user-images.githubusercontent.com/79155839/124355795-a59cf500-dc30-11eb-9a60-530de3a69979.png" alt="Instantiation of Multiplier IP"/>

 
  <li>Adder/Subtractor  Second Instantiation</li> 

 <ul>
       <li>Input Type: Signed</li>
       <li> Input Width: 64</li>
       <li> Add Mode: Add</li>
       <li>Output Width: 64</li>
       <li> Latency Configuration: Manual</li>
       <li> Latency: 1</li>
       <li> Implement using : Fabric</li>
       <li> Clock Enable: Ticked</li>
        
 </ul>

  <img src="https://user-images.githubusercontent.com/79155839/124356030-a7b38380-dc31-11eb-87bf-6bfc051de8aa.png" alt="Instantiation of Multiplier IP"/>
 
</ol>


    
      
  
