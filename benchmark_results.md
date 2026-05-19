# Ollama Model Benchmark Results
Date: Mon May 18 20:07:04 UTC 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 30Gi
- OS: Linux 6.17.0-23-generic
- GPU: NVIDIA Corporation GA106 [GeForce RTX 3060 Lite Hash Rate] (rev a1)

Prompt: *"Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."*

## Run 1
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2683 | 21.77 | 322 |
| fd-gemma4-26b-q8 | .3887 | 12.58 | 293 |
| fd-gemma4-31b | 2.4654 | 3.01 | 425 |
| fd-gemma4-e4b | .0270 | 76.43 | 425 |
| fd-qwen3-4b | .2607 | 17.72 | 4572 |
| fd-qwen3-coder-30b | .2589 | 31.97 | 157 |
| fd-qwen3.5-27b | 2.0735 | 3.18 | 186 |
| fd-qwen3.5-4b | .0398 | 67.77 | 305 |
| fd-qwen3.5-9b | .0505 | 47.04 | 215 |
| fd-qwen3.6-35b | .4535 | 11.64 | 1065 |

## Run 2
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2727 | 21.68 | 340 |
| fd-gemma4-26b-q8 | .3902 | 12.56 | 363 |
| fd-gemma4-31b | 2.4634 | 3.00 | 456 |
| fd-gemma4-e4b | .0262 | 75.83 | 565 |
| fd-qwen3-4b | .2617 | 17.74 | 4563 |
| fd-qwen3-coder-30b | .2591 | 31.97 | 157 |
| fd-qwen3.5-27b | 2.0764 | 3.17 | 186 |
| fd-qwen3.5-4b | .0372 | 67.93 | 483 |
| fd-qwen3.5-9b | .0503 | 46.98 | 358 |
| fd-qwen3.6-35b | .4403 | 11.66 | 1105 |

## Run 3
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2710 | 21.74 | 317 |
| fd-gemma4-26b-q8 | .3914 | 12.54 | 363 |
| fd-gemma4-31b | 2.4982 | 3.01 | 413 |
| fd-gemma4-e4b | .0270 | 75.92 | 555 |
| fd-qwen3-4b | .2611 | 18.10 | 4299 |
| fd-qwen3-coder-30b | .2589 | 31.97 | 157 |
| fd-qwen3.5-27b | 2.0796 | 3.17 | 199 |
| fd-qwen3.5-4b | .0397 | 67.78 | 465 |
| fd-qwen3.5-9b | .0507 | 47.14 | 215 |
| fd-qwen3.6-35b | .4409 | 11.63 | 1595 |

