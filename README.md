# Compiler
**Lex & Yacc 기반 언어 처리 시스템 구현**  <br>
이 과제들은 컴파일러 설계의 핵심 구성요소인 렉서(lexical analyzer)와 파서(syntax analyzer)의 구현 및 연동을 목적으로 하고 있습니다. 각각의 과제는 특정 기능을 수행하는 컴파일러의 하위 모듈 개발을 통해, 언어의 문법적 구조 분석과 토큰화(tokenization) 과정을 이해하고 실습하는 데 중점을 둡니다.

본 과제의 과제 제출 버전은  [Velog: Lex & Yacc 기반 언어 분석기 개발 과정](https://velog.io/@cheringring/Lex-Yacc-%EA%B8%B0%EB%B0%98-%EC%96%B8%EC%96%B4-%EB%B6%84%EC%84%9D%EA%B8%B0-%EA%B0%9C%EB%B0%9C-%EA%B3%BC%EC%A0%9C) 에 있습니다.

<br>

- 과제 1번-1 line_number.l / input.txt 
- 과제 1번 -2 line_number.l / data.p 
- 과제 2번 mycal_l.l / mycal_y.y / y.tab.c / y.tab.h 
- 과제 3번 pascal.y / scanner2.l / yascal.tab.c / pascal.tab.h / test.pas  


## 과제 1-1: 기본 렉서 구현 (Lex)
- **파일:** `line_number.l`, `input.txt`
### 기술적 목적
- **정규표현식 기반 토큰화 시스템 구축**
- **유한 상태 기계(Finite State Machine) 구현**
- **줄 단위 입력 처리 메커니즘 개발**

```
%{
#include <stdio.h>
int lineno = 1; /* 상태 유지 메커니즘 /
%}
%%
\n { lineno++; ECHO; } / 상태 전이 처리 /
^.$ { printf("%d\t%s", lineno, yytext); } /* 컨텍스트 인식 출력 */
```

## 과제 1-2: 고급 렉서 확장
- **파일:** `line_number.l`, `data.p`
### 기술적 개선점
- **빈 줄 처리 최적화 알고리즘**
- **패턴 매칭 엔진 성능 향상**
- **크로스 플랫폼 컴파일 지원**

```
%option noyywrap /* 링크 최적화 /
%%
^.\n { printf("%d\t%s", ++lineno, yytext); } /* 효율적 패턴 처리 */
```


## 과제 2: 구문 분석기 연동
- **파일:** `mycal_l.l`, `mycal_y.y`, `y.tab.c`, `y.tab.h`
### 시스템 아키텍처
- **LALR(1) 파서 생성기 통합**
- **연산자 우선순위 계층화**
- **의미 기반 번역 규칙 구현**

```
%left YPLUS YMINUS /* 결합성 정의 /
%left YMUL YDIV / 우선순위 그룹화 /
%%
expression
: expression YMUL expression { $$ = $1 * $3; } / 의미 동작 지정 */
```

## 과제 3: 의미 분석기 구현
- **파일:** `pascal.y`, `scanner2.l`, `y.tab.c`, `pascal.tab.h`, `test.pas`
### 핵심 기능
- **BNF 기반 확장 문법 지원**
- **동적 심볼 테이블 관리**
- **타입 검증 시스템 프로토타입**

```
var_decl
: YVAR variableIdList YCOLON YINTEGER {
add_symbol($1, VAR_TYPE); /* 심볼 정보 등록 */
}
```



## 컴파일러 기술 발전 단계
| 단계 | 기술 요소 | 구현 도구 |
|------|-----------|-----------|
| 어휘 분석 | 정규표현식, 토큰 분류 | Flex |
| 구문 분석 | LALR 파싱, 문법 규칙 | Bison |
| 의미 분석 | 타입 시스템, 심볼 테이블 | 사용자 정의 C 코드 |

## 이론적 토대
1. **Chomsky Hierarchy** (과제 1): 정규 문법 처리 능력
2. **Shift-Reduce Parsing** (과제 2): 충돌 해결 전략
3. **Attribute Grammar** (과제 3): $$=$1*$3 형태의 속성 전파

## 성능 최적화 기법
- **Lookahead 최소화**: LALR(1) 파싱 테이블 압축
- **메모리 관리**: 동적 심볼 테이블 재사용
- **오류 복구**: Panic-mode 에러 리커버리

> 전체 과제는 이론적 컴파일러 개념을 실제 3,500라인 수준의 구현체로 구체화하는 과정을 체험하도록 설계됨


