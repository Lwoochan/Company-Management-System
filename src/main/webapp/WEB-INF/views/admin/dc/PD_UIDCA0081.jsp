<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.tech.kr/jsp/jstl" prefix="ap" %>
<ap:globalConst />
<c:set var="svcUrl" value="${requestScope[SVC_URL_NAME]}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>정보</title>	
<ap:jsTag type="web" items="jquery,tools,ui,form,validate,notice,msgBoxAdmin,colorboxAdmin,mask,selectbox" />
<ap:jsTag type="tech" items="acm,msg,util" />
<script type="text/javascript">
<c:if test="${resultMsg != null}">
	$(function(){
		jsMsgBox(null, "info", "${resultMsg}");
	});
</c:if>

$(document).ready(function(){
	
  	 $("#dataForm").validate({  
			rules : {
			tarket_year: "required"    			
			}
			});
  	$("#tarket_year").numericOptions({from:2002,to:${inparam.curr_year},sort:"desc"});
  	
	$("#tarket_year").val('${inparam.stdYy}');
	$("#selectCondType").val('${inparam.selectCondType}');
});

/*
* 목록 검색
*/
function btn_relPossession_get_list() {

	var form = document.dataForm;
	
	form.df_curr_page.value = 1;
	form.df_method_nm.value = "findrelPossessionList";
	
	if($("#tarket_year").valid())
			form.submit();
}


/*
* 검색단어 입력 후 엔터 시 자동 submit
*/
function press(event) {
	if (event.keyCode == 13) {
		event.preventDefault();
		btn_relPossession_get_list();
	}
}

function deletemiLimitlist(){
	jsMsgBox(null,'confirm',"정말로삭제하시겠습니까?", 
		function(){
			$.ajax({
		        url      : "PGDC0030.do",
		        type     : "POST",
		        dataType : "json",
		        data     : { df_method_nm: "deletemiLimitlist", tarket_date: $("#curr_year_date").val() },
		        async    : false,                
		        success  : function(response) {
		        	try {
		                if(response.result) {
		            		jsMsgBox($(this),'info',Message.msg.deleteOk,btn_miLimit_get_list);

		                } else {
		                	jsMsgBox($(this),'info',response.value.errMsg);
		                }
		            } catch (e) {
		                if(response != null) {
		                	jsSysErrorBox(response);
		                } else {
		                    jsSysErrorBox(e);
		                }
		                return;
		            }                
		            
		        }
		    });
		});
}
</script>
</head>
<body>

	<form name="dataForm" id="dataForm" action="<c:url value='${svcUrl}' />" method="post">
		<ap:include page="param/defaultParam.jsp" />
		<ap:include page="param/dispParam.jsp" />
		<ap:include page="param/pagingParam.jsp" />
		
		
				<!-- LNB 출력 방지 -->
		<input type="hidden" id="no_lnb" value="true" />
		<input type="hidden" id="curr_year_date" value="${inparam.stdYy}" />
    <!-- 좌측영역 //-->
    <!--//content-->
 <div id="self_dgs">
	<div class="pop_q_con">
                <div class="search_top">
                    <table cellpadding="0" cellspacing="0" class="table_search" summary="조회 조건">
                        <caption>
                        조회 조건
                        </caption>
                        <colgroup>
                        <col width="15%" />
                        <col width="*" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">조회년도</th>
                                <td><select name="tarket_year" title="조회년도" id="tarket_year" style="width:130px">
                                    </select>
                                </td>
                                <th scope="row">조회항목</th>
                                <td><select name="selectCondType" title="선택" id="selectCondType" style="width:130px">
                                		<option  value="all">선택</option>
                                        <option  value="entrprsNm">모기업명</option>
                                        <option  value="drposentrprsNm">직접소유기업명</option>
                                        <option  value="ndrposentrprsNm">간접소유기업명</option>
                                    </select>
                                    <span class="only">
                                    <input name="searchKeyword" type="text" id="searchKeyword" style="width:170px" title="검색내용입력" placeholder="검색내용을 입력하세요."  onfocus="this.placeholder=''; return true"
                           			<c:if test="${inparam.searchKeyword != '' || inparam.searchKeyword ne null}">value="${inparam.searchKeyword}"</c:if> onkeypress="press(event);" />
                                    </span>
                                    <p class="btn_src_zone"><a href="#" class="btn_search" onclick="btn_relPossession_get_list();">조회</a></p></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="block">
                <ap:pagerParam addJsRowParam="null,'findrelPossessionList'"/>
                    <!--// 리스트 -->

                    <div class="list_zone">
                        <table cellspacing="0" border="0" summary="목록">
                            <caption>
                            리스트
                            </caption>
                            <colgroup>
                           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
				           <col width="*" />
                            </colgroup>
                            <thead>
                                <tr>
			                    <th scope="col">기준년</th>
			                    <th scope="col">법인등록번호</th>
			                    <th scope="col">사업자번호</th>
			                    <th scope="col">기업명</th>
			                    <th scope="col">직접_법인번호</th>
			                    <th scope="col">직접_기업명</th>
			                    <th scope="col">직접_지분율</th>
			                    <th scope="col">간접_법인번호1</th>
			                    <th scope="col">간접_기업명1</th>
			                    <th scope="col">간접_지분율1</th>
			                    <th scope="col">간접_법인번호2</th>
			                    <th scope="col">간접_기업명2</th>
			                    <th scope="col">간접_지분율2</th>
                                </tr>
                            </thead>
                            <tbody>
                           <c:choose>
							   	<c:when test="${fn:length(findrelPossessionList) > 0}">
								  	<c:forEach items="${findrelPossessionList}" var="info" varStatus="status">    
								  	 <tr>   
 								  	 	<td>${info.stdYy}</td>
 								  	 	<td class="tac">${info.jurirNo}</td>
 								  	 	<td>${info.bizrNo}</td>
 								  	 	<td class="tal">${info.entrprsNm}</td>
								  	 	<td>${info.drposjurirNo}</td>
								  	 	<td class="tal">${info.drposentrprsNm}</td>
								  	 	<td class="tar">${info.drposqotaRt}</td>
								  	 	<td>${info.ndrposjurirNo1}</td>
								  	 	<td class="tal">${info.ndrposentrprsNm1}</td>
								  	 	<td class="tar">${info.ndrposqotaRt1}</td>
								  	 	<td>${info.ndrposjurirNo2}</td>
								  	 	<td class="tal">${info.ndrposentrprsNm2}</td>
								  	 	<td class="tar">${info.ndrposqotaRt2}</td>
										</tr>
									</c:forEach>
								</c:when>
							   	<c:otherwise>
							   		<tr>
							   		<td colspan="13" style="text-align:center;">요청하신 조회년도의 기업직간접소유현황 정보가 없습니다.</td>
							   		</tr>
								   	</c:otherwise>
							</c:choose>							
							</tbody>
                        </table>
                    </div>
                    <!-- 리스트// -->
                    <!--리스트영역 //-->
                	<div class="btn_page_last"><a class="btn_page_admin" href="#" onclick="parent.$.fn.colorbox.close();"><span>닫기</span></a></div>
                
                    <div class="mgt10"></div>
                    <!--// paginate -->
                   	<ap:pager pager="${pager}"  addJsParam="'findrelPossessionList'"/>
					<!-- paginate //-->
                </div>
                <!--리스트영역 //-->
            </div>
        </div>
        </form>
        <!--content//-->
</body>
</html>