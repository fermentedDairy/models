# Ollama Model Benchmark Results
Date: Sun Jun 21 07:43:26 UTC 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 30Gi
- OS: Linux 6.17.0-35-generic
- GPU: NVIDIA Corporation GA106 [GeForce RTX 3060 Lite Hash Rate] (rev a1)

Prompt: *"Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."*

### Models Benchmarked
- fd-gemma4-12b
- fd-gemma4-26b
- fd-gemma4-26b-q8
- fd-gemma4-31b
- fd-gemma4-e4b
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
| fd-gemma4-12b | .1139 | 40.37 | 478 |
| fd-gemma4-26b | .6481 | 36.75 | 430 |
| fd-gemma4-26b-q8 | 1.1422 | 21.62 | 480 |
| fd-gemma4-31b | 1.5537 | 3.22 | 498 |
| fd-gemma4-e4b | .0514 | 74.57 | 927 |
| fd-qwen2.5-coder-14b | .4868 | 13.41 | 280 |
| fd-qwen2.5-coder-32b | 2.0814 | 3.77 | 305 |
| fd-qwen3-4b | .2906 | 25.51 | 571 |
| fd-qwen3-coder-30b | .3441 | 35.74 | 188 |
| fd-qwen3.5-27b | 1.8376 | 5.04 | 201 |
| fd-qwen3.5-4b | .1728 | 54.60 | 127970 |
| fd-qwen3.5-9b | .1051 | 53.41 | 1274 |
| fd-qwen3.6-35b | .5594 | 39.28 | 1314 |

## Run 2
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-12b | .1147 | 40.43 | 393 |
| fd-gemma4-26b | .5577 | 36.41 | 528 |
| fd-gemma4-26b-q8 | 1.4212 | 21.29 | 518 |
| fd-gemma4-31b | 1.5670 | 3.23 | 500 |
| fd-gemma4-e4b | .0443 | 75.12 | 930 |
| fd-qwen2.5-coder-14b | .4901 | 13.45 | 181 |
| fd-qwen2.5-coder-32b | 2.0701 | 3.80 | 200 |
| fd-qwen3-4b | .2963 | 17.27 | 5780 |
| fd-qwen3-coder-30b | .3434 | 36.21 | 180 |
| fd-qwen3.5-27b | 2.4976 | 3.93 | 181 |
| fd-qwen3.5-4b | .1633 | 81.62 | 342 |
| fd-qwen3.5-9b | .1144 | 53.96 | 592 |
| fd-qwen3.6-35b | .5575 | 38.18 | 1211 |

## Run 3
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-12b | .1166 | 40.39 | 393 |
| fd-gemma4-26b | .5585 | 36.45 | 529 |
| fd-gemma4-26b-q8 | 1.2614 | 21.59 | 453 |
| fd-gemma4-31b | 1.5708 | 3.28 | 471 |
| fd-gemma4-e4b | .0471 | 75.03 | 1016 |
| fd-qwen2.5-coder-14b | .4877 | 13.57 | 147 |
| fd-qwen2.5-coder-32b | 2.0755 | 3.78 | 281 |
| fd-qwen3-4b | .2936 | 18.96 | 4344 |
| fd-qwen3-coder-30b | .3498 | 36.14 | 180 |
| fd-qwen3.5-27b | 2.0313 | 4.97 | 202 |
| fd-qwen3.5-4b | .1343 | 79.88 | 8000 |
| fd-qwen3.5-9b | .1037 | 53.64 | 1235 |
| fd-qwen3.6-35b | .4840 | 36.31 | 1316 |

