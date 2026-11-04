# Ollama Model Benchmark Results
Date: Tue Nov  3 20:05:54 UTC 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 30Gi
- OS: Linux 6.17.0-41-generic
- GPU: NVIDIA Corporation GA106 [GeForce RTX 3060 Lite Hash Rate] (rev a1)

Prompt: *"Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."*

### Models Benchmarked
- fd-flint-40b
- fd-gemma4-12b
- fd-gemma4-26b
- fd-gemma4-26b-q8
- fd-gemma4-31b
- fd-gemma4-e4b
- fd-ornith-35b
- fd-ornith-9b
- fd-qwen2.5-coder-14b
- fd-qwen2.5-coder-32b
- fd-qwen3-4b
- fd-qwen3-coder-30b
- fd-qwen3.5-27b
- fd-qwen3.5-4b
- fd-qwen3.5-9b
- fd-qwen3.6-35b

## Run 1
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-flint-40b | 1.0648 | 55.86 | 438 |
| fd-gemma4-12b | 6.0766 | 42.12 | 538 |
| fd-gemma4-26b | 1.1907 | 22.33 | 871 |
| fd-gemma4-26b-q8 | 1.0839 | 23.57 | 632 |
| fd-gemma4-31b | 1.6182 | 3.19 | 492 |
| fd-gemma4-e4b | .0468 | 78.69 | 1053 |
| fd-ornith-35b | .6779 | 23.81 | 373 |
| fd-ornith-9b | .0710 | 57.64 | 132 |
| fd-qwen2.5-coder-14b | .0514 | 35.00 | 168 |
| fd-qwen2.5-coder-32b | 1.5598 | 4.24 | 281 |
| fd-qwen3-4b | .2377 | 28.99 | 434 |
| fd-qwen3-coder-30b | .2141 | 42.70 | 196 |
| fd-qwen3.5-27b | 1.4558 | 5.64 | 264 |
| fd-qwen3.5-4b | .1225 | 86.04 | 1591 |
| fd-qwen3.5-9b | .1217 | 55.67 | 373 |
| fd-qwen3.6-35b | .8567 | 38.73 | 868 |

## Run 2
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-flint-40b | .2875 | 52.80 | 245 |
| fd-gemma4-12b | .1226 | 42.00 | 630 |
| fd-gemma4-26b | .7589 | 41.85 | 735 |
| fd-gemma4-26b-q8 | 1.1441 | 23.60 | 562 |
| fd-gemma4-31b | 1.6324 | 3.19 | 513 |
| fd-gemma4-e4b | .0461 | 78.72 | 803 |
| fd-ornith-35b | .6684 | 53.74 | 495 |
| fd-ornith-9b | .0707 | 57.77 | 78 |
| fd-qwen2.5-coder-14b | .0513 | 35.15 | 148 |
| fd-qwen2.5-coder-32b | 1.5468 | 4.24 | 224 |
| fd-qwen3-4b | .2341 | 28.99 | 474 |
| fd-qwen3-coder-30b | .2191 | 42.41 | 207 |
| fd-qwen3.5-27b | 1.4266 | 5.65 | 254 |
| fd-qwen3.5-4b | .1419 | 86.16 | 1227 |
| fd-qwen3.5-9b | .0971 | 55.84 | 454 |
| fd-qwen3.6-35b | .5046 | 48.68 | 666 |

## Run 3
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-flint-40b | .2816 | 56.09 | 313 |
| fd-gemma4-12b | .1197 | 41.89 | 499 |
| fd-gemma4-26b | .7562 | 41.99 | 669 |
| fd-gemma4-26b-q8 | 5.5225 | 17.85 | 603 |
| fd-gemma4-31b | 1.6344 | 3.15 | 594 |
| fd-gemma4-e4b | .0445 | 79.40 | 1099 |
| fd-ornith-35b | .6722 | 54.16 | 494 |
| fd-ornith-9b | .0729 | 56.64 | 81 |
| fd-qwen2.5-coder-14b | .0514 | 34.99 | 176 |
| fd-qwen2.5-coder-32b | 1.5559 | 4.25 | 232 |
| fd-qwen3-4b | .2307 | 21.85 | 3116 |
| fd-qwen3-coder-30b | .2281 | 42.92 | 176 |
| fd-qwen3.5-27b | 1.4432 | 5.64 | 257 |
| fd-qwen3.5-4b | .1176 | 84.93 | 2955 |
| fd-qwen3.5-9b | .1207 | 55.84 | 401 |
| fd-qwen3.6-35b | .5104 | 46.31 | 1162 |

