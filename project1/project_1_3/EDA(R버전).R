library("tidyverse")
library("dplyr")
library("ggplot2")

credit = read.csv("C:/Users/rkd_w/OneDrive/바탕 화면/유비온-프로젝트1(신용카드)/dataset/BankChurners.csv")
head(credit)

glimpse(credit)
colnames(credit)


#나이대 별 열 추가
credit_m=credit %>% mutate((Age_bins = ifelse(Customer_Age < 30 , "20대",
                                              ifelse(Customer_Age >= 30 & Customer_Age < 40 , "30대",
                                                     ifelse(Customer_Age >=40 & Customer_Age <50,"40대",
                                                            ifelse(Customer_Age>=50 &Customer_Age <60 , "50대",
                                                                   "60대 이상"))))))
View(credit_m)
#열이름 바꾸기
colnames(credit_m)[24] = "Age_bins"


#범주형 변수로 변환
credit_m$Dependent_count=as.factor(credit$Dependent_count)
credit_m$Months_Inactive_12_mon=as.factor(credit$Months_Inactive_12_mon)
credit_m$Months_on_book=as.factor(credit$Months_on_book)
credit_m$Total_Relationship_Count=as.factor(credit$Total_Relationship_Count)
credit_m$Contacts_Count_12_mon=as.factor(credit$Contacts_Count_12_mon)
credit_m$Age_bins = as.factor(credit_m$Age_bins)
credit_m$Attrition_Flag = as.factor(credit_m$Attrition_Flag)
View(credit_m)


#성별분포
credit_m %>% group_by(Attrition_Flag , Gender) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Gender)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

#Marital_Status 분포
credit_m %>% group_by(Attrition_Flag , Marital_Status) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%

  ggplot(aes(x=Attrition_Flag, y = prop, fill = Marital_Status)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

#Dependent_count의 분포
credit_m %>% group_by(Attrition_Flag , Dependent_count) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Dependent_count)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")


#카드 카테고리의 unknwon은 비율이 매우 적어 전처리 삭제 해줌
credit_m %>% filter(Card_Category != "Unknown")


#Card_Category 그리기

credit_m %>% group_by(Attrition_Flag, Card_Category) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Card_Category)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")


#Incom_Category 분포
credit_m %>% group_by(Attrition_Flag, Income_Category) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Income_Category)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")



#Total_Relationship_Count 분포
credit_m %>% group_by(Attrition_Flag, Total_Relationship_Count) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Total_Relationship_Count)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")


#Months_Inactive_12_mon 분포
credit_m %>% group_by(Attrition_Flag, Months_Inactive_12_mon) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Months_Inactive_12_mon)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")


#Contacts_Count_12_mon분포
credit_m %>% group_by(Attrition_Flag, Contacts_Count_12_mon) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Contacts_Count_12_mon)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")


#Education_Level 분포
credit_m %>% group_by(Attrition_Flag , Education_Level) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Education_Level)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")





unique(credit_m$Education_Level)
min(credit$Customer_Age) #나이 최솟값 26

getwd()
setwd('C:/Users/rkd_w/OneDrive/바탕 화면')
getwd()
write.csv(credit_m ,"credit_change.csv")


##연속형변수 히스토그램

#언더샘플링인데 토멕링크 
dist_credit=read.csv('C:/Users/rkd_w/OneDrive/바탕 화면/유비온-프로젝트1(신용카드)/dataset/tomek.csv')
dist_credit$Attrition_Flag = as.factor(dist_credit$Attrition_Flag)
View(dist_credit)

dist_credit[which(duplicated(dist_credit$Attrition_Flag)),]
library(dplyr)
dist_credit %>% distinct(Attrition_Flag)

dim(dist_credit %>% filter(Attrition_Flag == '0'))
subset(count(dist_credit$Attrition_Flag), freq>1)
#Credit_Limit
ggplot(dist_credit,  aes(x = Credit_Limit , fill =Attrition_Flag, color =Attrition_Flag ))+
  theme(legend.position = "top") +
  geom_histogram(alpha = 0.5 , position = 'stack')


#Total_Revolving_Bal
ggplot(dist_credit,  aes(x = Credit_Limit , fill =Attrition_Flag, color =Attrition_Flag ))+
  theme(legend.position = "top") +
  geom_histogram(alpha = 0.5 , position = 'stack')

colnames(dist_credit)

#연속-> 범주
dist_credit=read.csv('C:/Users/rkd_w/OneDrive/바탕 화면/유비온-프로젝트1(신용카드)/dataset/카드이탈범주생성.csv')
View(dist_credit)

#credit_limit_범주
dist_credit %>% group_by(Attrition_Flag, credit_limit_범주) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = credit_limit_범주)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

#Total_Revolving_Bal_범주
dist_credit %>% group_by(Attrition_Flag, Total_Revolving_Bal_범주) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Total_Revolving_Bal_범주)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

#Total_Amt_Chng_Q4_Q1_범주
dist_credit %>% group_by(Attrition_Flag, Total_Amt_Chng_Q4_Q1_범주) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Total_Amt_Chng_Q4_Q1_범주)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

#Avg_Open_To_Buy_범주
dist_credit %>% group_by(Attrition_Flag, Avg_Open_To_Buy_범주) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Avg_Open_To_Buy_범주)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

#Total_Trans_Amt_범주
dist_credit %>% group_by(Attrition_Flag, Total_Trans_Ct_범주) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Total_Trans_Ct_범주)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

#Total_Ct_Chng_Q4_Q1_범주
dist_credit %>% group_by(Attrition_Flag, Total_Ct_Chng_Q4_Q1_범주) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Total_Ct_Chng_Q4_Q1_범주)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

#Avg_Utilization_Ratio_범위
dist_credit %>% group_by(Attrition_Flag, Avg_Utilization_Ratio_범주) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Avg_Utilization_Ratio_범주)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

#Customer_Age_범주
dist_credit %>% group_by(Attrition_Flag, Customer_Age_범주) %>% summarise(count = n()) %>% mutate(prop = round(count/sum(count), 3)) %>%
  
  ggplot(aes(x=Attrition_Flag, y = prop, fill = Customer_Age_범주)) + geom_bar(stat = "identity", position = "dodge") +
  
  geom_text(aes(label = paste(prop*100, "%")), size = 5, position = position_dodge(.9), vjust = 1) + scale_fill_brewer(palette = "RdPu") + xlab("Attrition_Flag")

