# Ollama Model Benchmark Results
Date: Thu Nov 19 00:58:39 UTC 2026
System Specs:
- CPU:                              AMD Ryzen 5 5500
- RAM: 30Gi
- OS: Linux 6.17.0-41-generic
- GPU: Intel Corporation Battlemage G21 [Intel Graphics]

Prompt: *"Write a short kotlin function that calculates the nth Fibonacci number. Use a recursive function without memoisation."*

## Models Benchmarked
| Model |
| :--- |
| fd-agents-A1-35B |
| fd-devstral-small-2-24b |
| fd-flint-40b |
| fd-gemma4-12b |
| fd-gemma4-26b |
| fd-gemma4-e4b |
| fd-glm-4.7-flash |
| fd-gpt-oss-20b |
| fd-ornith-35b |
| fd-ornith-9b |
| fd-ornith1.5-35b |
| fd-qwen3-4b |
| fd-qwen3-coder-30b |
| fd-qwen3.5-4b |
| fd-qwen3.5-9b |
| fd-qwen3.8-27b |

Jitter is calculated as the difference between the maximum and minimum token rates observed across the benchmark runs.

### fd-agents-A1-35B

#### Model Statistics

```
NAME                       ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-agents-A1-35B:latest    2c143259d938    21 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .420514 | 218.78 | 72.22 | 179 token(s) |
| 2 | .145536 | 27.48 | 72.19 | 392 token(s) |
| 3 | .145160 | 27.56 | 70.92 | 353 token(s) |
| Average | .2370 | 91.27 | 71.77 | 308 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 70.92 |
| Max Token Rate (tokens/s) | 72.22 |
| Jitter (tokens/s) | 1.30 |


### fd-devstral-small-2-24b

#### Model Statistics

```
NAME                              ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-devstral-small-2-24b:latest    5c7b2c839eec    20 GB    100% GPU     65536      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .059994 | 383.37 | 26.90 | 194 token(s) |
| 2 | .041617 | 24.03 | 26.90 | 174 token(s) |
| 3 | .043663 | 22.90 | 26.87 | 175 token(s) |
| Average | .0484 | 143.43 | 26.89 | 181 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 26.87 |
| Max Token Rate (tokens/s) | 26.90 |
| Jitter (tokens/s) | .03 |


### fd-flint-40b

#### Model Statistics

```
NAME                   ID              SIZE     PROCESSOR         CONTEXT    RUNNER      UNTIL   
fd-flint-40b:latest    6ec9a7c92ed9    23 GB    1%/99% CPU/GPU    12288      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .483059 | 47.61 | 38.22 | 513 token(s) |
| 2 | .162249 | 30.82 | 18.17 | 468 token(s) |
| 3 | .162837 | 30.71 | 18.39 | 398 token(s) |
| Average | .2693 | 36.38 | 24.92 | 459 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 18.17 |
| Max Token Rate (tokens/s) | 38.22 |
| Jitter (tokens/s) | 20.05 |


### fd-gemma4-12b

#### Model Statistics

```
NAME                    ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-gemma4-12b:latest    b1c8ae3f6841    7.7 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .300333 | 296.34 | 41.35 | 317 token(s) |
| 2 | .118500 | 42.19 | 41.34 | 151 token(s) |
| 3 | .114844 | 43.54 | 41.38 | 153 token(s) |
| Average | .1778 | 127.35 | 41.35 | 207 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 41.34 |
| Max Token Rate (tokens/s) | 41.38 |
| Jitter (tokens/s) | .04 |


### fd-gemma4-26b

#### Model Statistics

```
NAME                    ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-gemma4-26b:latest    640e3ef200af    15 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .421625 | 211.09 | 20.22 | 483 token(s) |
| 2 | .198029 | 25.25 | 19.31 | 750 token(s) |
| 3 | .688136 | 7.27 | 42.87 | 418 token(s) |
| Average | .4359 | 81.20 | 27.46 | 550 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 19.31 |
| Max Token Rate (tokens/s) | 42.87 |
| Jitter (tokens/s) | 23.56 |


### fd-gemma4-e4b

#### Model Statistics

```
NAME                    ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-gemma4-e4b:latest    15019e288f2d    528 MB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .072314 | 1037.14 | 148.52 | 177 token(s) |
| 2 | .452842 | 11.04 | 148.88 | 283 token(s) |
| 3 | .045156 | 110.73 | 135.84 | 169 token(s) |
| Average | .1901 | 386.30 | 144.41 | 209 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 135.84 |
| Max Token Rate (tokens/s) | 148.88 |
| Jitter (tokens/s) | 13.04 |


### fd-glm-4.7-flash

#### Model Statistics

```
NAME                       ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-glm-4.7-flash:latest    5b16c4d3e228    19 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .249560 | 88.16 | 3.25 | 442 token(s) |
| 2 | .034673 | 28.84 | 17.71 | 549 token(s) |
| 3 | .041495 | 24.10 | 18.91 | 722 token(s) |
| Average | .1085 | 47.03 | 13.29 | 571 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 3.25 |
| Max Token Rate (tokens/s) | 18.91 |
| Jitter (tokens/s) | 15.66 |


### fd-gpt-oss-20b

#### Model Statistics

```
NAME                     ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-gpt-oss-20b:latest    796b9c80857d    12 GB    100% GPU     65536      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .251990 | 91.27 | 67.42 | 334 token(s) |
| 2 | .021679 | 46.13 | 67.69 | 182 token(s) |
| 3 | .025680 | 38.94 | 67.42 | 248 token(s) |
| Average | .0997 | 58.78 | 67.51 | 254 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 67.42 |
| Max Token Rate (tokens/s) | 67.69 |
| Jitter (tokens/s) | .27 |


### fd-ornith-35b

#### Model Statistics

```
NAME                    ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-ornith-35b:latest    53ebeb33889c    21 GB    100% GPU     8192       llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .395866 | 234.93 | 71.72 | 294 token(s) |
| 2 | .144503 | 27.68 | 72.00 | 463 token(s) |
| 3 | .142759 | 28.02 | 71.54 | 418 token(s) |
| Average | .2277 | 96.87 | 71.75 | 391 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 71.54 |
| Max Token Rate (tokens/s) | 72.00 |
| Jitter (tokens/s) | .46 |


### fd-ornith-9b

#### Model Statistics

```
NAME                   ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-ornith-9b:latest    9ea89610ef17    6.0 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .280895 | 331.08 | 57.95 | 82 token(s) |
| 2 | .071706 | 55.78 | 57.31 | 117 token(s) |
| 3 | .061384 | 65.16 | 57.50 | 169 token(s) |
| Average | .1379 | 150.67 | 57.58 | 122 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 57.31 |
| Max Token Rate (tokens/s) | 57.95 |
| Jitter (tokens/s) | .64 |


### fd-ornith1.5-35b

#### Model Statistics

```
NAME                       ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-ornith1.5-35b:latest    bbebdea62c74    21 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .406586 | 233.65 | 70.48 | 200 token(s) |
| 2 | .146539 | 27.30 | 70.95 | 137 token(s) |
| 3 | .144244 | 27.73 | 71.37 | 214 token(s) |
| Average | .2324 | 96.22 | 70.93 | 183 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 70.48 |
| Max Token Rate (tokens/s) | 71.37 |
| Jitter (tokens/s) | .89 |


### fd-qwen3-4b

#### Model Statistics

```
NAME                  ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3-4b:latest    921a1ab5d17e    4.0 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .019471 | 1386.68 | 92.39 | 1179 token(s) |
| 2 | .011785 | 84.85 | 92.83 | 723 token(s) |
| 3 | .011804 | 84.72 | 90.53 | 1625 token(s) |
| Average | .0143 | 518.75 | 91.91 | 1175 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 90.53 |
| Max Token Rate (tokens/s) | 92.83 |
| Jitter (tokens/s) | 2.30 |


### fd-qwen3-coder-30b

#### Model Statistics

```
NAME                         ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3-coder-30b:latest    899e1c042be1    20 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .182325 | 137.12 | 78.24 | 106 token(s) |
| 2 | .015485 | 64.58 | 78.20 | 106 token(s) |
| 3 | .019016 | 52.59 | 77.71 | 106 token(s) |
| Average | .0722 | 84.76 | 78.05 | 106 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 77.71 |
| Max Token Rate (tokens/s) | 78.24 |
| Jitter (tokens/s) | .53 |


### fd-qwen3.5-4b

#### Model Statistics

```
NAME                    ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.5-4b:latest    7b7cae4d45bc    3.4 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .091467 | 852.77 | 83.94 | 1488 token(s) |
| 2 | .058369 | 68.53 | 84.40 | 844 token(s) |
| 3 | .058129 | 68.81 | 83.97 | 1224 token(s) |
| Average | .0693 | 330.03 | 84.10 | 1185 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 83.94 |
| Max Token Rate (tokens/s) | 84.40 |
| Jitter (tokens/s) | .46 |


### fd-qwen3.5-9b

#### Model Statistics

```
NAME                    ID              SIZE      PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.5-9b:latest    2a5c36a62b7e    6.3 GB    100% GPU     32768      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .445318 | 211.09 | 57.22 | 229 token(s) |
| 2 | .069740 | 57.36 | 57.41 | 203 token(s) |
| 3 | .062717 | 63.78 | 57.41 | 229 token(s) |
| Average | .1925 | 110.74 | 57.34 | 220 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 57.22 |
| Max Token Rate (tokens/s) | 57.41 |
| Jitter (tokens/s) | .19 |


### fd-qwen3.8-27b

#### Model Statistics

```
NAME                     ID              SIZE     PROCESSOR    CONTEXT    RUNNER      UNTIL   
fd-qwen3.8-27b:latest    808c31c7ca04    17 GB    100% GPU     16384      llamacpp    Forever    
```

| Run | Prompt Eval Time (s) | Prompt Eval Rate (tokens/s) | Eval Rate (tokens/s) | Total Tokens (tokens) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | .606315 | 151.74 | 56.79 | 324 token(s) |
| 2 | .212412 | 18.83 | 37.98 | 271 token(s) |
| 3 | .185073 | 21.61 | 34.30 | 386 token(s) |
| Average | .3346 | 64.06 | 43.02 | 327 |

#### Performance Metrics
| Metric | Value |
| :--- | :--- |
| Min Token Rate (tokens/s) | 34.30 |
| Max Token Rate (tokens/s) | 56.79 |
| Jitter (tokens/s) | 22.49 |


