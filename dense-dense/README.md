<h1>Row_wise Dense x Dense</h1>
<p>This repository contains the necessary verilog files required to implement row-wise dense-dense matrix multiplication. The matrix dimensions are 560x560.</p>

<h2>Description of files </h2>
<ol>
  <li> top.sv </li>
    <p>This module instantiates the design and the testbench.</p>
  <li> mul_dense.v </li>
    <p>This file has the design code that implements the multiplication. It makes use of various IPs.</p>
  <li> comparator.v </li>
    <p>A simple 32-bit comparator, used by the design file.</p>
  <li> shift_reg.v </li>
    <p>A shift register, used by design file.</p>
  <li> slow_clk.v </li>
    <p>Generates a clock signal that is 28 times slower than the main clock.</p>
  <li> dense_tb.sv </li>
    <p>This is used by the top module to generate stimilus and drive the design file.</p>
</ol>

<h2>IP Instantiation </h2>

<p>Variour Xilinx IPs were used, and below are all their configurations.</p>
<ol>
  <li>Block Memory Generator</li>
    <ul>
      <li>Memory type: Simple Dual Port RAM </li>
      <li>Common clock: Checked</li>
      <li>Port A options: </li>
      <ul>
        <li>Width: 64 </li>
        <li>Depth: 280 </li>
        <li>Enable Port type: Always Enabled </li>
      </ul>
      <li>Port B options: </li>
      <ul>
        <li>Width: 64</li>
        <li>Depth: 280</li>
        <li>Enable Port type: Use ENB pin </li>
        <li>Primitive Ouput register: Checked</li>
        <li>Core Ouput register: Checked</li>
      </ul>
    </ul>
    <br>
    <img src="https://user-images.githubusercontent.com/64745965/124482219-af586100-ddc6-11eb-9756-6f43a7e0d1ff.png" alt="BRAM"/>
    <br>
    <br>
  <li>Adder/Subtractor</li>
    <ul>
      <li>Implement using: Fabric</li>
      <li>Input type: Signed</li>
      <li>Input width: 64</li>
      <li>Add mode: Add</li>
      <li>Output width: 64</li>
      <li>Latency configuration: Automatic</li>
      <li>Latency: 6</li>
      <li>Control: Bypass: Checked</li>
    </ul>
    <br>
     <img src="https://user-images.githubusercontent.com/64745965/124482252-b67f6f00-ddc6-11eb-9f16-c7a975b8512e.png" alt="adder_page1"/>
     <img src="https://user-images.githubusercontent.com/64745965/124482265-b97a5f80-ddc6-11eb-93e0-d3d28752594f.png" alt="adder_page2"/>
    <br>
    <br>
  <li>Multiplier</li>
    <ul>
      <li>Multiplier type: Parallel Multiplier</li>
      <li>Data type: Signed</li>
      <li>Input width: 32</li>
      <li>Multiplier construction: Use Mults</li>
      <li>Pipeline Stages: 6</li>
    </ul>
    <br>
    <img src="https://user-images.githubusercontent.com/64745965/124482288-bed7aa00-ddc6-11eb-9772-c50035199100.png" alt="Multiplier"/>
</ol>


