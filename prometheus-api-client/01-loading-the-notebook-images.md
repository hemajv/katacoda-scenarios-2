### What is SARIMA?
Autoregressive Integrated Moving Average, or ARIMA, is one of the most widely used forecasting methods for univariate time series data forecasting. Although this method can handle data with a trend, it does not support time series with a seasonal component i.e. time series with a repeating cycle. An extension to ARIMA that supports the direct modeling of the seasonal component of the series is called SARIMA.

SARIMA adds three new hyperparameters to specify the autoregression (AR), differencing (I) and moving average (MA) for the seasonal component of the series, as well as an additional parameter for the period of the seasonality.

### What are hyperparameters?
They are simply the very "knobs" one "turns" when building/tuning a statistical learning model. A model hyperparameter is a configuration that is external to the model and whose value cannot be estimated from data. These hyperparametrs effect the speed and quality of the model training process. Different model training algorithms require different hyperparameters, some simple algorithms (such as ordinary least squares regression) require none. Given these hyperparameters, the training algorithm learns the parameters from the data.

We cannot know the best value for a model hyperparameter on a given problem. We may use rules of thumb, copy values used on other problems, or search for the best value by trial and error.

When a machine learning algorithm is tuned for a specific problem, then you are tuning the hyperparameters of the model or order to discover the parameters of the model that result in the most skillful predictions.

### How to configure SARIMA?
Configuring a SARIMA requires selecting hyperparameters for both the trend and seasonal elements of the series. There are three **trend** elements that require configuration. These are the ones that are configured in the standard ARIMA model.

* **p** - Trend autoregression order (AR part)

 - *It allows to incorporate the effect of past values into our model. Intuitively, this would be similar to stating that it is likely to be warm tomorrow if it has been warm the past 3 days.*

* **d** - Trend difference order (I part)

 - *It is the number of nonseasonal differences needed for stationarity. Intuitively, this would be similar to stating that it is likely to be same temperature tomorrow if the difference in temperature in the last three days has been very small.*

* **q** - Trend moving average order (MA part)

 - *It is the number of lagged forecast errors in the prediction equation. This allows us to set the error of our model as a linear combination of the error values observed at previous time points in the past.*

There are four **seasonal** elements that are not part of ARIMA that must be configured; they are:

* **P**: Seasonal autoregressive order.
* **D**: Seasonal difference order.
* **Q**: Seasonal moving average order.
* **m**: The number of time steps for a single seasonal period.

The Seasonal portion `(P, D, Q)m` has the same structure as the non-seasonal parts. It may — but does not have to include — an AR factor, an MA factor, and/or an I factor. In this part of the model, all of these factors operate across the number of period `(m)` in your season. This seasonality is a regular pattern of changes that repeats over `m` time periods. E.g. If there is a seasonal factor of 3 over a time series of monthly data, the pattern repeats every quarter.

Put these all together and you get a `SARIMA (p, d, q) x (P, D, Q)m` which is what we’re looking to build.

The exact model we’ll be using from the python package `statsmodels` is the `SARIMAX`, where `X` is the use of an exogenous explanatory variable (the X part of SARIMAX). We’re not going to get into adding exogenous variables to our model, so you can ignore this for now. The default will be `none` when we run the model as we don't have any extra variable to include at the moment.

Together, the notation for a SARIMA model is specified as:

```
SARIMAX(order=(p,d,q), seasonal_order=(P,D,Q,m))
```
Source: http://www.statsmodels.org/dev/generated/statsmodels.tsa.statespace.sarimax.SARIMAX.html
