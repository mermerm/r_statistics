
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
# https://github.com/siestageek/python_statistics

# 통계
# 통계학 유형
1. 기술통계학   
2. 추론통계학   
3. 베이즈통계학


# 표본추출방법
* 단순랜덤
* 계통추출
* 층화추출
* 군집추출

* 복원추출
    + 표본을 하나 추출한 후 다시 모집단에 넣은 후 그 다음 표본을 추출하는 방식
    $$ m \times m \times \cdots \times m = m^n $$
    $$ _m{\pi}_n $$
    
* 비복원추출
    + 한번 뽑은 표본은 모집단에 넣지 않고 다음 표본을 추출
    $$ m(m-1)(m-2) \cdots  (m-n+1) = _m{P}_n$$

* R에서는 sample  함수를 이용해서 표본을 추출할 수 있음
    + sample(모집단, 표본수, 복원/비복원 여부)

```{r}
sample(1:10, 5, replace=T)  # 복원추출
```

```{r}
sample(1:10, 5, replace=F)  #비복원 추출
```    

```{r}
menu <- c('라면', '우동', '메밀', '파스타', '짜장면')
sample(menu, 5, replace=T) # 같은 메뉴가 3번 나오면 당첨!
```

    

# 자료의 종류
* 질적자료  
    + 명목자료
    + 순서자료
    + 구간자료
    + 비율자료
    
    
* 양적자료
    + 이산형
    + 연속형
    

```
타이타닉 자료에서 성별, 승선위치별, 승선권 등급별 승객 비율을 조사해서 출력하세요.
```

```{r, echo=FALSE}
setwd('C:/Users/tjoeun/Desktop/R 주말반/datasets')
titanic <- read.csv('titanic.csv')
head(titanic)

```

```{r}
summary(titanic)
```
```{r}
#성별 승객 현황
frq_gender <- table(titanic$sex)
barplot(frq_gender)
```

```{r}
# 승선권 등급별 승객 현황
frq_ticket <- table(titanic$pclass)
frq_ticket
barplot(frq_ticket)
```

```{r}
# 승선위치별 승객 현황
frq_emb <- table(titanic$embarked)
frq_emb
barplot(frq_emb)
```

```{r}
# 나이별 승객 현황 1
# 양적자료는 구간ㄴ척도로 변환해서 시각화
age <- titanic$age
summary(age) # 양적자료
boxplot(age)
```

```{r}
# 나이별 승객 현황 1
# 양적자료는 구간척도로 변환해서 시각화

# 먼저, 나이와 나이대를 저장할 데이터프레임 생성
age <- titanic$age[!is.na(titanic$age)]
ages <- as.character(age)

df_age <- data.frame(age, ages, stringsAsFactors = F)
head(df_age, 10)
```


```{r}
# 나이 데이터를 토대로 명목변수 생성
df_age <- within(df_age, {
    ages[age <= 1] <- '~01'
    ages[age >= 2 & age < 5] <- '~05'
    ages[age >= 5 & age < 13] <- '~13'
    ages[age >= 13 & age < 19] <- '~18'
    ages[age >= 19 & age < 30] <- '~20    '
    ages[age >= 30 & age < 40] <- '~30'
    ages[age >= 40 & age < 50] <- '~40'
    ages[age >= 50 & age < 60] <- '~50'
    ages[age >= 60 & age < 70] <- '~60'
    ages[age >= 70 & age < 80] <- '~70'
    ages[age >= 80] <- '~80'
})

head(df_age$ages, 10)
```

```{r}
# 분류된 결과에 대한 빈도표 작성
frq_ages <- table(df_age$ages)
frq_ages
```


```{r}
# 빈도표를 바탕으로 막대그래프 시각화
barplot(frq_ages)
```

```{r}
# 나이별 승객 현황 2
# 양적자료는 구간척도로 변환해서 시각화
hist(age, xlim=c(0,80))
```

# 통계 중요 용어
* 모집단
    + 이름 $U$, 크기 $N$
    
*표본
    + 이름 $S$, 크기 $n$

# 중심화 경향
    + 수집한 자료 전체를 대표하는 값이 무엇인지 나타내는 통계(대표값)
    + 평균
    + 중앙값
    + 최빈값

# 분산화 경향
    + 데이터가 어떻게 분포되어 있는지 설명하는 통계치
    + 범위
    + 사분위수
    + 분산
    + 표준편차
    
# 대표값
### 평균 : 중심척도의 대표적인 통계값
![](http://cfile3.uf.tistory.com/image/254D394756D671100BE5E4)

### 모평균
* $\mu \ =  \dfrac{1}{n} \sum_{n=1}^N x_i$

### 표본평균
* $\bar x = \dfrac{1}{n} \sum_{i=1}^n x_i$ 

```{r}
# 평균 : mean(x, na.rm=F)
# x : 평균을 구할 대상
# 결측치 포함 여부
x = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

mean(x)

```

```{r}
# 조선조 왕들의 평균수명은?
kings <- c(73,62,45,53,38,16,51,28,37,30,56,30,33,56,
         66,54,40,33,59,36,82,48,44,22,32,67,52)
mean(kings)
```
### 중앙값
* 자료를 오름차순으로 나열한 후 가장 가운데 놓인 수
* 특이값의 영향을 받는 평균을 보완한 수치
* 자료 갯수가 짝수인 경우와 홀수인 경우 계산하는 방법이 다름
* $M_e$


```{r}
# 중앙값 : median(x, na.rm=F)
a <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
median(a)
b <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
median(b)
```

```{r}
# 다음 값들의 중앙값을 계산하세요.
x<- c(12, 7, 3, 4.2, 18, 2,  54, -21, 8, -5)
sort(x)
median(x)
```

### 최빈값
* 두번 이상 발생하는 자료 중에서 자주 나타나는 자료값
* 극단값에 전혀 영향을 받지 않음
* 존재하지 않거나 여러개 존재할 수 있음
* $M_O$
* R에서는 최빈값을 구하는 함수가 제공되지 않음
* table 함수와 which.max 함수를 이용해서 구하도록 함

```{r}
# 최빈값
# 빈도표 작성 : table(x)
# 최대빈도 요소 위치값 조사 :  which.max(x)
# 빈도표의 컬럼명 조사 : names(x)
x <- c(2, 1, 2, 3, 1, 2, 3, 4, 1, 5, 5, 3, 2, 3)
sort(x)
frqx <- table(x)
frqx

```
```{r}
maxidx <- which.max(frqx)
names(maxidx)
# 주의) 위 예에서는 최빈값이 2개인데 1개만 나옴
```

```{r}
# 최빈값 구하는 함수 : get_mode
getmode <- function(x){
    
}
```

```{r}
# 평균이 동일한 자료들
a <- c(1,2,3,4,5,5,5,6,7,8,8,9,9,9,9)
b <- c(4,5,5,5,6,6,6,6,6,6,6,7,7,7,8)
mean(a)
mean(b)
# 두 자료 모두 평균은 동일하지만 자료의 구성은 다름
```
### 범위
* $R$
* 수집한 자료의 가장 큰 값과 작은 값의 차이
* 수집한 자료가 어느정도 흩어져 있는지 살펴볼 수 있는 통계치
* 계산하기 쉽다
* 특이값에 영향을 많이 받는다
* 범위가 동일해도 분산정도는 크게 다를 수 있다
* $R = x_{(n)} - x_{(1)}$

```{r}
# 범위 : range(x)
range(a)
range(b)

```
```{r}
# 조선조 왕들의 평균수명의 범위는?
range(kings)
max(kings)-min(kings)
sort(kings)
```

### 분산
* 평균을 중심으로 밀집되거나 퍼짐 정도를 나타내는 척도
* 모분산 $\sigma^2$ : 모집단을 구성하는 모든 자료값과 모평균의 편차제곱에 대한 평균
    + $\sigma^2 = \dfrac{1}{N} \sum_{i=1}^N ( x_i - \mu )^2$, $\mu$ = 모평균
* 표본분산 $s^2$ : 표본을 구성하는 모든 자료값과 표본평균의 편차의 제곱합을 $n-1$로 나눈 수치
    + $S^2 = \dfrac{1}{n-1} \sum_{i=1}^n (x_i - \bar x )^2$, $\bar x$ = 표본평균
* 자료가 자료가 평균에 **밀집할수록 작아짐**
![](https://camo.githubusercontent.com/d940dd3ee3714fb61d6537384b92f64d3aad398e/68747470733a2f2f64726976652e676f6f676c652e636f6d2f75633f69643d315752494e6a46326d7159755146347a435733464c6d6f4552584956305a4c496f)

```{r}
# 분산 :  var(x)
# 조선조 왕들의 평균수명의 분산은?
var(kings)
# 결과값이 뭔가 이상?
```
```{r}
my.var <- function(x) { 
    m <- mean(x)  # 평균계산
    # return (sum((x - m)^2)/(length(x)) #모분산
    return (sum((x - m)^2)/(length(x)-1)) #표본분산
}
my.var(kings)
```

```{r}
# 어떤 카푸치노 판매점들의 5일동안 오후 4~5시 사이의 판매량 데이터를 보고 어느 지점이 판매를 잘하였는지 파악하시오.
ga <- c(20, 40, 50, 60, 80)
na <- c(20, 45, 50, 55, 80)

summary(ga)
summary(na)
# 중심화 경향으로 기술통계 실시 => 가늠할 수 없음

var(ga)
var(na)
# 위치척도(분산)로 두 집단의 차이를 알아봄
# 가 집단의 분산이 나 집단의 분산보다 큼
# 나 집단의 카푸치노가 일정하게 팔리고 있음

```

### 표준편차
* 분산값에 제곱근을 취한 값
* 분산은 편차를 제곱했기 때문에 결과값의 단위 역시 제곱이 됨
* 분산의 단위를 원래 자료의 단위로 전환하기 위해 만든 값
* 분산을 구하기 위해 편차 ($x_i - \bar x$)의 제곱합을 구함
* 편차의 제곱합 때문에 값이 너무 커짐
* 따라서, 분산값에 제곱근을 취함으로써 측정값과 같은 단위로 변환할 수 있음
    + $S =\sqrt{\dfrac{1}{n-1} \sum_{i=1}^n (x_i - \bar x )^2}$

```{r}
# 표준편차 : sd(x)
# 조선조 왕들의 수명의 표준편차는?
sd(kings)
```
```{r}
# 회계사원들의 월급과 사무수습사원들의 월급의 차이를 비교해보시오.
# 단, 사무수습사원의 평균월급은 3550,  표준편차는 250이다.
acc <- c(3536, 3173, 3448, 3121, 3622)
summary(acc)
sd(acc)
```


### 사분위수
* 대표적인 위치척도를 이용한 기술통계
* 관측치를 여러 부분으로 나눠 각 값들의 위치를 결정
* 데이터를 가장 작은수부터 가장 큰수까지 정렬하였을 때 1/4, 2/4, 3/4 위치에 있는 수
* 사분위수를 구하는 방법은 데이터의 유형과 방식에 따라 9가지가 존재
* $Q_1, Q_2, Q_3, Q_4$

#### 사분위수 구하는 방법
* 먼저, 중앙값을 구함 : 2사분위수
* 중앙값을 기준으로 왼쪽방향의 1사분위수를 구함
* 중앙값을 기준으로 오른쪽방향의 3사분위수를 구함

```{r}
# 표본이 다음과 같을 때 Q1, Q2, Q3를 구하세요.
nums <- c(1, 3, 4, 7, 10, 11, 20, 22, 25, 30, 31)

fivenum(nums)
quantile(nums, type=1) # 값 기반
quantile(nums, type=6) # 위치기반
```



```{r}
boxplot(nums)
```


```{r}
# 사분위수 : quantile(x, type)
# 위치 기준 사분위수 : fivenum(x)
# 비연속형 수치(위치기준) : type 1 ~ 3 (1추천)
# 연속형 수치(값기준) : type 4 ~ 9 (6추천)

x <- c(1, 2, 3, 4, 10, 50, 100)
quantile(x)
quantile(x, type=1)
quantile(x, type=2)
quantile(x, type=3)

fivenum(x)


```
```{r}
# 1, 2, 2, 4, 4, 6, 7, 8, 9, 10, 12, 12의 사분위수는?
Q <- c(1, 2, 2, 4, 4, 6, 7, 8, 9, 10, 12, 12)
fivenum(Q)
quantile(Q)
quantile(Q, type=6)
```

### 사분위수 활용방법
* fivenum : 상자수염그래프와 같이 사용
* quantile : 일반적인 사분위수


### 비대칭도
* 중심지 경향과 분포 경향을 통해 표본의 특성과 산포 정도 파악 가능
* 분포가 좌우대칭/완만 정도를 파악하기 어려움
* 표본의 도수분포에서 평균에 대한 비대칭 방향과 정도를 어느정도 알 수 있음

```{r}
# 80명의 학생데이터에 대한 시각화실행
# 먼저, 도수분포표를 작성해야 함
setwd('C:/Users/tjoeun/Desktop/R 주말반/datasets')
height <- read.csv('height.csv')
head(height)
```

```{r}
# 구간 파악 : 최대/최소 파악
min <- min(height)
max <- max(height)
# min # 143 -> 140(내림)
# max #169 -> 170(올림)
min <- (as.integer(min/10))*10
max <- (as.integer(max/10))*10+10

```
```{r}
# 구간별 범위 지정
bins <- seq(140, 170, 5)
bins
```
```{r}
# 계급값 : 각 계급을 대표하는 값, 계급의 중앙값
# 140 145 150 155 160 165 170
mid <- ((bins[2] - bins[1]) / 2)
mdbins <- bins + mid
mdbins
```
```{r}
# 상대도수 구하기 : 전체도수/전체빈도수
total <- length(height$height)
h<- hist(height$height)
relfrq <- h$counts / total
relfrq
sum(relfrq)
```
```{r}
# 누적도수 : 각 구간별 도수의 누적합
# 누적합 : cumsum(x)
h$counts
csfrq <- cumsum(h$counts)
csfrq

```
```{r}
# 히스토그램, 계급값, 상대도수, 누적도수 시각화
hist(height$height)

```
```{r}
# 히스토그램, 계급값, 상대도수, 누적도수 시각화
plot(mdbins[1:6], h$counts, type='b', col='red')

```
```{r}
# 히스토그램, 계급값, 상대도수, 누적도수 시각화
plot(mdbins[1:6], relfrq, type='l', col='orange')

```

```{r}
# 히스토그램, 계급값, 상대도수, 누적도수 시각화
plot(mdbins[1:6], csfrq, type='b', col='blue')

```
```{r}
hist(height$height, freq=F)
lines(density(height$height), col='red') # 확률밀도곡선
```
    
###왜도
* 분포곡선이 좌측이나 우측으로 어느정도 쏠렸는지 나타냄
* 왜도가 0보다 크면 왼쪽으로 쏠리는 분포를 나타냄
* 즉, 오른쪽으로 꼬리가 긴 분포를 나타냄

### 첨도
* 분포곡선의 봉우리가 얼느정도로 뾰족한지 나타냄
* 첨도가 3보다 크면 폭이 좁고 봉우리가 높은 분포를 나타냄
* 간혹 프로그램에 따라 0을 기준으로 측정하는 경우도 있음


```{r}
# R에서는 moments 패키지의 skew와 kurtosi 함수를 이용
# 왜도 : skewness(x)
# 첨도 :kurtosis(x)
# install.packages('moments')
library(moments)
```


```{r}
# 청소년 핸드폰 사용시간에 대한 히스토그램과 KDE을 작성하세요
phone <- c(10,37,22,32,18,15,15,18,22,15,20,25,38,28,
         25,30,20,22,18,22,22,12,22,26,22,32,22,23,
         20,23,23,20,25,51,20,25,26,22,26,28,28,20,
         23,30,12,22,35,11,20,25)

hist(phone, freq=F)
lines(density(phone), col='red')
skewness(phone)
kurtosis(phone)
```

### 확률밀도추정
* kernal density estimation
* 관측된 데이터의 분포로부터 원래 변수의 확률분포특성을 추정
* 즉, 해당변수에서 관측된 몇가지 데이터로부터 변수가 가질 수 있는 모든 값들에 대한 밀도(확률)을 추정하는 것

```{r}
# 어떤 IT회사의 주당 이익자료이다.
#0.09, 0.13, 0.41, 0.51, 1.12, 1.20, 1.49, 3.18, 3.50, 6.36, 7.83, 8.92, 10.13, 12.99, 16.40
# 평균, 사분위값, 표준편차, 왜도, 첨도는?

rev <- c(0.09, 0.13, 0.41, 0.51, 1.12, 1.20, 1.49, 3.18, 3.50, 6.36, 7.83, 8.92, 10.13, 12.99, 16.40)
mean(rev)
quantile(rev)
sd(rev)
skewness(rev)
kurtosis(rev)
```


