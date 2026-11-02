# Gemini-TDG Bounded Dataset Study Results

## Overall Performance vs Dataset Bound (k)

| Configuration | Bound (k) | Pairs | Refuted (NEQ) | Refutation % | Avg Datasets | Avg Gen Time (s) | Time/Pred (s) | Avg Tokens/Inst | Total Tokens |
| :--- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Bounded (k=1) | 1 | 343 | 304 | 88.6% | 1.00 | 0.58s | 0.127s | 113 | 8,494 |
| Bounded (k=3) | 3 | 344 | 324 | 94.2% | 2.96 | 19.05s | 4.210s | 3,714 | 282,299 |
| Bounded (k=5) | 5 | 343 | 338 | 98.5% | 5.00 | 20.56s | 4.497s | 4,177 | 313,238 |
| Bounded (k=10) | 10 | 343 | 335 | 97.7% | 9.83 | 24.50s | 5.358s | 4,847 | 363,559 |
| Unrestricted | ∞ (Unres.) | 343 | 339 | 98.8% | 5.36 | 18.51s | 4.047s | 3,909 | 293,154 |

## Refutation Rate by Benchmark

| Configuration | LARGEJOIN | XDATA | OVERALL |
| :--- | ---: | ---: | ---: |
| Bounded (k=1) | -- | 304/343 (88.6%) | 304/343 (88.6%) |
| Bounded (k=3) | 1/1 (100.0%) | 323/343 (94.2%) | 324/344 (94.2%) |
| Bounded (k=5) | -- | 338/343 (98.5%) | 338/343 (98.5%) |
| Bounded (k=10) | -- | 335/343 (97.7%) | 335/343 (97.7%) |
| Unrestricted | -- | 339/343 (98.8%) | 339/343 (98.8%) |

