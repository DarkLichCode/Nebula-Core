# Day 000 Why Develop This Operating System

## 1. Origin

The story of **Nebula-Core** traces back to a creative competition a few years ago, where I first encountered the **VisionFive2** development board. The competition's theme was to develop applications around it—IoT devices, game consoles, etc. While that competition eventually passed, the board's potential left a lasting impression on me.

Recently, as I revisited this hardware, my perspective shifted. I moved beyond simple "application development" to the foundational challenge of **"system architecture"**.



## 2. Standing on the Shoulders of Giants

In the RISC-V operating system community, **rCore** is a seminal milestone. Seeing the rCore tutorial execute smoothly on the K210 (dual-core 64-bit RISC-V) not only validated the feasibility of writing an OS in Rust but also sparked a hypothesis:

> *Since early embedded chips like the K210 can host a Rust kernel, can I replicate—and extend—this process on the VisionFive 2, leveraging its superior performance and modern architecture?*



## 3. The Real Goal

The VisionFive 2 is equipped with the **JH7110 SoC**, featuring four U74 cores.

In general embedded development, this implies raw speed. But for operating system research, this represents a perfect **SMP (Symmetric Multiprocessing)** testbed.

While dual-core scheduling on the K210 has precedents, a **quad-core environment** introduces exponential complexity. Issues like **kernel lock contention**, **task load balancing**, and **inter-core cache coherence** become critical challenges—and fascinating research opportunities.



## 4. Next

Consequently, I initiated the Nebula-Core project. This is not merely about developing a kernel; it is an attempt to seize this opportunity to investigate **Rust's concurrency model** within multi-core scheduling algorithms.

My objective is to extract maximum performance from these four cores through optimized scheduling strategies, **using high-throughput synthetic workloads (such as parallel matrix multiplication or software rendering) to stress-test the scheduler.**