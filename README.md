<h1>Column_wise_560</h1>
<p>This is the repository containing the column-wise implementation of matrix multiplication for the matrix dimension of 560 x 560. I have also assumed that the first matrix is a sparse matrix with the NNZ=8960.</p>
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


    
      
  
