---
title: "R markdown"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# R 마크다운 제목1
## R 마크다운 제목 2
### R 마크다운 제목 3
#### R 마크다운 제목 4
##### R 마크다운 제목 5
###### R 마크다운 제목 6

# 줄바꿈 (스페이스 3번)
첫번째 줄   
두번째 줄   
세번재 줄

# 글자꾸미기
문장 내에서 **진하게** 표시할 수 있어요   
문장 내에서 _기울어지게_ 표시할 수 있어요   
문장 내에서 ~~취소선~~ 표시할 수 있어요



# 구분선 출력하기
***


# 인용구 출력하기
> 당신이 만약 힘들다면 그건 당신의 인생을 살고있지 않기 때문이다.


# 코드 삽입하기
``` 
a = read.csv('EMPLOYEE.csv')
```


# 순서있는 목록 표시

1. 산점도
    1. 산점도
        1. 산점도
            2. 히스토그램
3. 박스그래프
4. 파이그래프

# 순서없는 목록표시

* 산점도
  + 산점도
    - 산점도
* 히스토그램
* 박스그래프
* 파이그래프


# 링크 만들기

[구글로 이동](http://google.com)   
[네이버로 이동](http://naver.com)


# 이미지 출력하기
![](https://www.thesprucepets.com/thmb/nuRZVBLSTh8yjg7Z6ATVnQZ2vLU=/1927x1445/smart/filters:no_upscale()/GettyImages-626916125-5b3a4a8046e0fb00379f682d.jpg)


# 테이블 출력하기
<!-- : 정렬 -->

| 이름 | 국어 | 영어 | 수학 |
|------|:-----|:----:|-----:|
| 혜교 | 99   | 98   | 87   |
| 지현 | 65   | 55   | 39   |
| 수지 | 75   | 21   | 58   |

<!-- table(데이터, 기타 옵션) -->
```{r kable}
knitr::kable(head(mtcars[, 1:8], 10), 
             booktabs=TRUE, caption='mtcars 상위 10개 자료')
```

# 수식 표현하기 : latex 


##### https://ko.wikipedia.org/wiki/%EC%9C%84%ED%82%A4%EB%B0%B1%EA%B3%BC:TeX_%EB%AC%B8%EB%B2%95


$$ a^2 = b^2 +c^2 $$

$$ \sum_{i=1}^{N} x_i $$

$\alpha \beta \gamma$


$\bar{x} = {{(x_1 + x_2 + x_3 + \cdots + x_n)} \over {n}} =  {1 \over n}  \sum_{i=1}^n x_i$

$X_N = { n+1 \over 2} 번째~ 측정치, (n이~ 홀수인 ~경우)$

$= {{{ n \over 2} 번째~수 + {n+2 \over 2 } 번째~수} \over 2} ,(n이~짝수인~경우)$


# github
* 분산 소스 버전 관리인 git을 웹으로 제공하는 클라우드 사이트
* 자신이 작성한 코드파일을 github에 업로드해두면 다른 개발자들과 같이 공유할 수 있음
* 또한, 자신이 공유해 둔 소스를 분기fork해서 
* 새로운 종류를 개발할 수도 있음(오픈소스의 장점)


```{r cars}
summary(cars)
```



```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
