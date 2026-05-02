---
layout: post
title: Drawing the flash attention animation
---


Some time ago, I was studying how Flash Attention works.

The main material available is the [pyramid visualization](https://github.com/dao-ailab/flash-attention) from the Flash Attention paper.

I wanted the visualization to be animated. I did not manage to find a good resource out there [^existing]. So I made mine.

[^existing]: There exists an [animation](https://github.com/Dao-AILab/flash-attention/pull/736) made by LuisAVasquez, but I want to stay as close to the source material as possible.

The [animation](https://tonghuikang.github.io/flash-attention-animation/) was made with MacOS Keynote, manually. [^benchmark]. As of writing, it appears to rank second on [Google search](https://www.google.com/search?q=flash+attention+animation).

[^benchmark]: I think a good benchmark for AI these days is to reproduce this work.

I also wrote [a Quora answer](https://www.quora.com/How-does-flash-attention-work/answer/Tong-Hui-Kang-1) explaining how Flash Attention works.

I asked in the GPU Mode Discord for opinions on my work.

[gau.nernst](https://x.com/gaunernst) replied with the following comments, which I greatly appreciate.

> i wanted to comment that the loop order was reversed. but upon checking, turns out FA1 used this loop ordering, but FA2 reversed it (and I only read the FA2 paper lmao)
> 
> so in FA2, iterating along K/V is the inner loop, iterating along Q/O is the outer loop, which is implemented as 1 threadblock handling 1 Q/O tile
>
> yea I think FA3 and FA4 also follow the FA2's general design, but optimized for Hopper and Blackwell respectively

The explanation may not be complete, the details may not be fully correct, but I still hope this makes it slightly easier for you to understand Flash Attention.

### Footnotes


