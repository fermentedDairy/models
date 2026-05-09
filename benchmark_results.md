# Ollama Model Benchmark Results
Date: Fri May  8 14:53:12 UTC 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 14Gi
- OS: Linux 6.17.0-23-generic
- GPU: NVIDIA Corporation GA106 [GeForce RTX 3060 Lite Hash Rate] (rev a1)

Prompt: *"Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."*

## Run 1
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2802 | 20.73 | 559 |
| fd-gemma4-26b-q8 | N/A | N/A | 0 |
| fd-gemma4-31b | N/A | N/A | 0 |
| fd-gemma4-e4b | .0270 | 76.41 | 499 |
| fd-qwen3-4b | .2591 | 25.51 | 496 |
| fd-qwen3.5-27b | 2.0767 | 3.12 | 217 |
| fd-qwen3.5-4b | .0373 | 66.51 | 3914 |
| fd-qwen3.5-9b | .0509 | 46.95 | 254 |
| fd-qwen3.6-35b | 1.9646 | 9.50 | 1380 |

## Run 2
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2828 | 20.74 | 536 |
| fd-gemma4-26b-q8 | N/A | N/A | 0 |
| fd-gemma4-31b | N/A | N/A | 0 |
| fd-gemma4-e4b | .0270 | 75.97 | 601 |
| fd-qwen3-4b | .2611 | 18.65 | 3937 |
| fd-qwen3.5-27b | 2.0729 | 3.13 | 205 |
| fd-qwen3.5-4b | .0391 | 66.53 | 3756 |
| fd-qwen3.5-9b | .0504 | 46.89 | 370 |
| fd-qwen3.6-35b | 4.4843 | 4.59 | 1561 |

## Run 3
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-gemma4-26b | .2952 | 20.34 | 768 |
| fd-gemma4-26b-q8 | N/A | N/A | 0 |
| fd-gemma4-31b | N/A | N/A | 0 |
| fd-gemma4-e4b | .0270 | 76.09 | 503 |
| fd-qwen3-4b | .2615 | 18.49 | 4060 |
| fd-qwen3.5-27b | 2.1098 | 3.13 | 186 |
| fd-qwen3.5-4b | .0374 | 67.46 | 452 |
| fd-qwen3.5-9b | .0510 | 46.89 | 416 |
| fd-qwen3.6-35b | 3.5070 | 4.33 | 1564 |

