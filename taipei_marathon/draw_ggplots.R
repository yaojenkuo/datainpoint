library(ggplot2)
library(dplyr)
library(magrittr)
library(ggtheme)
library(scale)
library(plotly)

runner_by_year_gender <- df %>%
  group_by(year, gender) %>%
  summarise(finishers = n())

gg1 <- ggplot(runner_by_year_gender, aes(x = year, y = finishers, fill = gender)) +
  geom_bar(stat = "identity") + 
  geom_text(aes(x = year, y = finishers, label = finishers), colour = "white", position = position_stack(vjust = 0.5)) +
  ggtitle("臺北馬拉松完賽人數逐年升高") +
  theme_economist() +
  scale_fill_economist() +
  theme(axis.ticks.y = element_blank(), text = element_text(family = "Heiti TC Light"), legend.position = "bottom", legend.direction = "horizontal", legend.title = element_blank()) +
  scale_x_continuous(breaks = seq(min(runner_by_year$year), max(runner_by_year$year), 1)) +
  xlab("") +
  ylab("")

gg2 <- ggplot(runner_by_year_gender, aes(x = year, y = finishers, color = gender)) +
  geom_line(lwd = 2) + 
  geom_text(aes(x = year, y = finishers, label = finishers, vjust = -1, size = 5), show.legend = FALSE) +
  ggtitle("臺北馬拉松女性完賽人數穩定成長") +
  theme_economist() +
  scale_colour_economist() +
  theme(axis.ticks.y = element_blank(), text = element_text(family = "Heiti TC Light"), legend.position = "bottom", legend.direction = "horizontal", legend.title = element_blank()) +
  scale_x_continuous(breaks = seq(min(runner_by_year$year), max(runner_by_year$year), 1)) +
  xlab("") +
  ylab("")

runner_by_year_gender_time_group <- df %>%
  group_by(year, gender, net_time_group) %>%
  summarise(finishers = n()) %>%
  mutate(ttl = sum(finishers),
         prop = finishers/ttl)

gg3 <- ggplot(runner_by_year_gender_time_group, aes(x = year, y = finishers, fill = net_time_group)) +
  geom_bar(stat = "identity", position = 'fill') + 
  ggtitle("臺北馬拉松快速完賽跑者比例上升") +
  scale_x_continuous(breaks = seq(min(runner_by_year$year), max(runner_by_year$year), 1)) +
  scale_y_continuous(labels = percent) +
  theme_economist() +
  scale_fill_economist() +
  theme(axis.ticks.y = element_blank(), text = element_text(family = "Heiti TC Light"), legend.position = "bottom", legend.direction = "horizontal", legend.title = element_blank()) +
  xlab("") +
  ylab("")

fast_runners <- runner_by_year_gender_time_group %>%
  filter((gender == "男" & net_time_group %in% c("sub 2:30", "sub 3:00")) | (gender == "女" & net_time_group %in% c("sub 2:30", "sub 3:00", "sub 3:30", "sub 4:00"))) %>%
  group_by(year, gender) %>%
  summarise(fast_runner_cnt = sum(finishers))

female_basis <- fast_runners[1, "fast_runner_cnt"]
male_basis <- fast_runners[2, "fast_runner_cnt"]
fast_runners$basis <- unlist(ifelse(fast_runners$gender == "女", female_basis, male_basis))
fast_runners$fast_runner_net_increase <- fast_runners$fast_runner_cnt - fast_runners$basis

gg4 <- ggplot(fast_runners, aes(x = year, y = fast_runner_cnt, fill = gender)) +
  geom_bar(stat = "identity", position = 'dodge') +
  geom_text(aes(x = year, y = fast_runner_cnt - 3, label = fast_runner_cnt), colour = "white", position = position_dodge(width = 0.9), size = 5) +
  ggtitle("更多男性選手可以 sub 3、女性選手可以 sub 4") +
  scale_x_continuous(breaks = seq(min(fast_runners$year), max(fast_runners$year), 1)) +
  theme_economist() +
  scale_fill_economist() +
  theme(axis.ticks.y = element_blank(), text = element_text(family = "Heiti TC Light"), legend.position = "bottom", legend.direction = "horizontal", legend.title = element_blank()) +
  xlab("") +
  ylab("")

label_heights <- ifelse(fast_runners$fast_runner_net_increase < 0, fast_runners$fast_runner_net_increase + 1.5, fast_runners$fast_runner_net_increase - 1.5)
gg5 <- ggplot(fast_runners, aes(x = year, y = fast_runner_net_increase, fill = gender)) +
  geom_bar(stat = "identity", position = 'dodge') +
  geom_text(aes(x = year, y = label_heights, label = fast_runner_net_increase), colour = "white", position = position_dodge(width = 0.9), size = 5) +
  ggtitle("2017 年高速完賽的男性女性選手與 2011 年相比共多出 174 位") +
  scale_x_continuous(breaks = seq(min(fast_runners$year), max(fast_runners$year), 1)) +
  theme_economist() +
  scale_fill_economist() +
  theme(axis.ticks.y = element_blank(), text = element_text(family = "Heiti TC Light"), legend.position = "bottom", legend.direction = "horizontal", legend.title = element_blank()) +
  xlab("") +
  ylab("")

ggplotly(gg1)
ggplotly(gg2)
ggplotly(gg3)
ggplotly(gg4)
ggplotly(gg5)