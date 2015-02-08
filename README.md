# LongVs130-30Trading
A comparison of All long vs 130/30 Trading using technical indicator

The objective of this analysis is to compare trading strategies using a set of ETFs and a technical indicator.
The strategy can be either long only or 130-30.

The code is structured in the following way:
- MainFunction.m is the main function that calls Investment.m.
- Investment.m further calls Trend_matrices.m (that in turn calls the Trender.m) to generate the decisions based on the technical indicator
- Investment.m also calls Markowitz (that in turn calls Stats.m) to run the Markowitz optimization.

