<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>

</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Register</div>
					<div class="panel-body">
							<div class="form-group">
								<label>Bno</label> 
								<input class="form-control" name='bno' 
									value='<c:out value="${board.bno}"/>' readonly="readonly">
							</div>
							<div class="form-group">
								<label>Title</label> <input class="form-control" name='title' 
								value='<c:out value="${board.title}"/>' readonly="readonly">
							</div>
							<div class="form-group">
								<label>Text Area</label> <textarea class="form-control" rows="3" name='content' readonly="readonly">
								<c:out value="${board.content}"/>
								</textarea>
								
							</div>
							<div class="form-group">
								<label>Writer</label> <input class="form-control" name='writer' 
								value ='<c:out value="${board.writer}"/>' readonly="readonly">
							</div>
					<!-- 		
					<button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">Modify</button> 
					 -->
					 <!-- 
							<button data-oper="list" class="btn btn-info" onclick="location.href='/board/list'">List</button>
						-->
							<button data-oper="modify" class="btn btn-default">Modify</button>
							<button data-oper="list" class="btn btn-info" >List</button>
							
							<form id='operForm' action="/board/modify" method="get">
								<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
								<input type='hidden' name ='pageNum' value='<c:out value="${cri.pageNum}"/>'>
								<input type='hidden' name ='amount' value='<c:out value="${cri.amount}"/>'>
            					<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
								<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
							</form>
							
							
					</div>
			</div>
		</div>
	</div>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>

// localhost9094/board/get?
console.log("==========================");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>';

console.log("bnoValue:" + bnoValue);

//for replyService add test
replyService.add(
		   {reply:"JS Test", replyer:"tester", bno:bnoValue}
		   ,
		   function(result){
			   alert("추가 성공 RESULT: " + result);
		   }
	);
	
console.log("=============");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>'

// http://localhost:9094/board/get?pageNum=1&amount=10&type=&keyword=&bno=314
replyService.getList({bno:bnoValue, page:1},function(list){
	
	for(var i = 0, len = list.length||0; i < len; i++){
		console.log(list[i]);
	}
	
});

//24번 댓글 삭제 테스트
replyService.remove(11, function(count){
	
	console.log(count);
		
		if(count === "success"){
			alert("REMOVED 성공");
		}
	}, function(err){
		alert('삭제 ERROR...');
	});


//22번 댓글 수정
replyService.update({
	rno : 25,
	bno : bnoValue,
	reply : "Modified Reply...."
}, function(result){
	alert("수정 완료...");
});
</script>
<script type="text/javascript">
       $(document).ready(function(){
    	   
    	   var operForm = $("#operForm");
    	   
    	   $("button[data-oper='modify']").on("click", function(e){
    		   
    		   operForm.attr("action","/board/modify").submit();
    		   
    		
    		   
    	   });
    	   
    	   $("button[data-oper='list']").on("click",function(e){
    		   
    		   operForm.find("#bno").remove();
    		   operForm.attr("action","/board/list")
    		   operForm.submit();
    		   
    	   });
    	   
       	
      
       	
       });
</script>        

<%@include file="../includes/footer.jsp" %>

