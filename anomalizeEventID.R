# Created from Anomalize project, Matt Dancho
# https://github.com/business-science/anomalize

library(tidyverse)
library(anomalize)

security_access_logs %>%
  ggplot(aes(date, count)) +
  geom_point(color = "#2c3e50", alpha = 0.25) +
  facet_wrap(~ server, scale = "free_y", ncol = 3) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
  labs(title = "Server Logon Counts",
       subtitle = "Data from Security Event Logs, Event ID 4624")

security_access_logs %>%
  # Data Manipulation / Anomaly Detection
  time_decompose(count, method = "stl") %>%
  anomalize(remainder, method = "iqr") %>%
  time_recompose() %>%
  # Anomaly Visualization
  plot_anomalies(time_recomposed = TRUE, ncol = 3, alpha_dots = 0.25) +
  labs(title = "Security Event Log Anomalies", subtitle = "STL + IQR Methods") 

# Get only SERVER-549521 access
SERVER549521 <- security_access_logs %>%
  filter(server == "SERVER-549521") %>% 
  ungroup()

# Anomalize!!
SERVER549521 %>%
  # Twitter + GESD
  time_decompose(count, method = "twitter", trend = "3 months") %>%
  anomalize(remainder, method = "gesd") %>%
  time_recompose() %>%
  # Anomaly Visualziation
  plot_anomalies(time_recomposed = TRUE) +
  labs(title = "SERVER-549521 Anomalies", subtitle = "Twitter + GESD Methods")

SERVER549521 %>%
  # STL + IQR Anomaly Detection
  time_decompose(count, method = "stl", trend = "3 months") %>%
  anomalize(remainder, method = "iqr") %>%
  time_recompose() %>%
  # Anomaly Visualization
  plot_anomalies(time_recomposed = TRUE) +
  labs(title = "SERVER-549521 Anomalies", subtitle = "STL + IQR Methods")

security_access_logs %>%
  filter(server == "SERVER-549521") %>%
  ungroup() %>%
  time_decompose(count) %>%
  anomalize(remainder) %>%
  plot_anomaly_decomposition() +
  labs(title = "Decomposition of Anomalized SERVER-549521 Logins")

