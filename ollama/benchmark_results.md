# Ollama Model Benchmark Results
Date: Fri Nov 13 20:22:38 UTC 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 30Gi
- OS: Linux 6.17.0-41-generic
- GPU: Intel Corporation Battlemage G21 [Intel Graphics]

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
| fd-flint-40b | .4578 | 36.78 | 316 |
| fd-gemma4-12b | .2689 | 28.51 | 592 |
| fd-gemma4-26b | .2830 | 45.95 | 539 |
| fd-gemma4-26b-q8 | 4.5370 | 4.88 | 555 |
| fd-gemma4-31b | 1.7946 | 6.11 | 478 |
| fd-gemma4-e4b | .0845 | 152.40 | 855 |
| fd-ornith-35b | 1.9870 | 33.95 | 475 |
| fd-ornith-9b | .0956 | 60.25 | 144 |
| fd-qwen2.5-coder-14b | .0518 | 39.95 | 185 |
| fd-qwen2.5-coder-32b | .7080 | 5.00 | 236 |
| fd-qwen3-4b | .0203 | 97.46 | 423 |
| fd-qwen3-coder-30b | .1801 | 84.41 | 195 |
| fd-qwen3.5-27b | .7877 | 14.16 | 423 |
| fd-qwen3.5-4b | .0687 | 83.47 | 2622 |
| fd-qwen3.5-9b | .0839 | 57.18 | 1731 |
| fd-qwen3.6-35b | .6777 | 16.33 | 1833 |

## Run 2
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-flint-40b | .4713 | 36.80 | 413 |
| fd-gemma4-12b | .2695 | 40.39 | 572 |
| fd-gemma4-26b | .2836 | 45.63 | 773 |
| fd-gemma4-26b-q8 | 4.7844 | 17.90 | 592 |
| fd-gemma4-31b | 1.7549 | 6.11 | 562 |
| fd-gemma4-e4b | .0846 | 150.85 | 795 |
| fd-ornith-35b | 1.9339 | 71.21 | 480 |
| fd-ornith-9b | .1269 | 48.14 | 65 |
| fd-qwen2.5-coder-14b | .0456 | 39.90 | 174 |
| fd-qwen2.5-coder-32b | .6489 | 6.90 | 309 |
| fd-qwen3-4b | .0205 | 89.33 | 4096 |
| fd-qwen3-coder-30b | .1756 | 84.18 | 181 |
| fd-qwen3.5-27b | .7199 | 20.89 | 461 |
| fd-qwen3.5-4b | .0669 | 84.00 | 1429 |
| fd-qwen3.5-9b | .0828 | 57.47 | 323 |
| fd-qwen3.6-35b | .7764 | 14.94 | 1177 |

## Run 3
| Model | TTFT (s) | Tokens/sec | Total Tokens |
| :--- | :--- | :--- | :--- |
| fd-flint-40b | .4649 | 11.26 | 256 |
| fd-gemma4-12b | .2716 | 40.19 | 662 |
| fd-gemma4-26b | .2861 | 18.12 | 628 |
| fd-gemma4-26b-q8 | 5.2217 | 15.56 | 641 |
| fd-gemma4-31b | 1.8125 | 6.12 | 503 |
| fd-gemma4-e4b | .0896 | 68.13 | 821 |
| fd-ornith-35b | 1.1900 | 72.16 | 459 |
| fd-ornith-9b | .0961 | 60.53 | 135 |
| fd-qwen2.5-coder-14b | .0612 | 18.55 | 167 |
| fd-qwen2.5-coder-32b | .6595 | 6.92 | 281 |
| fd-qwen3-4b | .0202 | 91.50 | 2770 |
| fd-qwen3-coder-30b | .1871 | 84.68 | 199 |
| fd-qwen3.5-27b | .2300 | 12.48 | 264 |
| fd-qwen3.5-4b | .0800 | 32.54 | 1244 |
| fd-qwen3.5-9b | .0800 | 57.60 | 269 |
| fd-qwen3.6-35b | 2.2683 | 15.10 | 1322 |

