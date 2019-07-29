<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11B00000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<%--
// 여러개 쓰면 ajax에서 받아올 때 에러남. 값은 받아와서 성공인 걸로 code 200 뜨는데, 그게 에러 메세지로 뜸;;
<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11D10000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11D20000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11C20000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11C10000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11F20000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11F10000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11H10000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11H20000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
<c:import url="http://newsky2.kma.go.kr/service/MiddleFrcstInfoService/getMiddleLandWeather?serviceKey=Q7T5OefX9mY0ggE1SkdLhU2r6CCdSUfajzQSM9rTgYJ2eHpxi9o%2FnPIH%2FKNeJ%2F%2Bl6O7n9r4vwE7VBej3jr4qTg%3D%3D&regId=11G00000&tmFc=${requestScope.tmFc}"  charEncoding="UTF-8"/>
 --%>

<%-- 배열 받아서 foreach로 돌리면 오류나서 수작업 함.. 근데 이것도 안 먹힘...... 떳다 말았다 지 맘대로임...
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=90&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=93&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=95&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=98&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=99&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=100&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=101&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=102&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=104&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=105&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=106&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=108&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=112&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=114&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=115&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=119&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=121&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=127&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=129&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=130&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=131&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=133&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=135&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=136&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=137&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=138&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=140&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=143&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=146&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=152&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=155&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=156&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=159&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=162&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=165&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=168&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=170&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=172&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=174&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=175&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=177&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=184&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=185&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=188&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=189&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=192&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=201&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=202&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=203&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=211&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=212&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=216&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=217&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=221&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=226&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=232&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=236&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=238&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=243&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=244&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=245&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=247&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=248&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=251&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=252&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=253&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=254&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=255&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=257&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=258&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=259&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=260&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=261&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=262&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=263&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=264&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=266&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=268&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=271&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=272&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=273&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=276&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=277&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=278&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=279&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=281&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=283&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=284&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=285&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=288&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=289&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=294&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
<c:import url="https://apis.openapi.sk.com/weather/summary?version=2&stnid=295&appKey=c9aca8f5-d344-4518-bf6d-424fb6af2d71" charEncoding="UTF-8"/>
--%>




