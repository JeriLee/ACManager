<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/7/9
  Time: 22:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>比赛详情 - ACManager</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">
    <c:url value="/assign/listTraining/${trainingId}" var="suijifendui"/>
    <c:url value="/training/doAddStage" var="url_doadstage"/>
    <c:url value="/training/verifyUserJoin" var="url_verifyUserJoin"/>

    <script>

        $(document).ready(function () {
            $('#mytable').DataTable({
                columnDefs: [
                    //给第一列指定宽度为表格整个宽度的20%
                    { "width": "30px", "targets": 2 }
                ],
                "order": [[3, "desc"], [4, "asc"]]
            });
        });
    </script>

</head>
<body>

<div class="container">
    <jsp:include page="topBar.jsp" />
    <div class="row">
        <ol class="breadcrumb">
            <li>您所在的位置：</li>
            <li><a href="<c:url value="/training/list"/> ">集训列表</a></li>
            <li><a href="<c:url value="/training/detail/${trainingId}"/> ">阶段列表</a></li>
            <li><a href="<c:url value="/training/stage/${stageId}"/> ">比赛列表</a></li>
            <li class="active">比赛详情</li>
        </ol>
    </div>

    <div class="row" style="padding-bottom: 20px">
        <div class="pull-right">
            <a href="<c:url value="/contest/showScore/${contest.id}"/>" class="btn btn-primary">比赛统计</a>
         </div>
    </div>

    <div class="row">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">${contest.name}&nbsp;&nbsp;详情</h3>
            </div>
            <div class="panel-body">
                <p>比赛时间：${contest.startTime} —— ${contest.endTime}</p>
                <p>
                    <c:set value="PERSONAL" var="Personal"/>
                    <c:set value="TEAM" var="Team"/>
                    <c:set value="MIX_TEAM" var="MixTeam"/>

                    比赛类型：
                    <c:choose>
                        <c:when test="${contest.type eq Personal}">
                            个人赛
                        </c:when>
                        <c:when test="${contest.type eq Team}">
                            组队赛
                        </c:when>
                        <c:when test="${contest.type eq MixTeam}">
                            组队赛
                        </c:when>
                    </c:choose>
                </p>
                <table class="table table-condensed table-striped table-hover display" id="mytable">
                    <thead class="tab-header-area">
                    <tr>
                        <th>排名</th>
                        <th>比赛账号</th>
                        <th>成员</th>
                        <th>题数</th>
                        <th>罚时</th>
                        <c:set value="ABCDEFGHIJKLMNOPQRSTUVWXYZ" var="ti"/>
                        <c:forEach begin="1" end="${contest.pbCnt}" var="i">
                            <th>${ti.charAt(i-1)}</th>
                        </c:forEach>
                        <%--<th>操作</th>--%>
                    </tr>
                    </thead>
                    <tfoot>

                    </tfoot>

                    <tbody>
                        <c:forEach items="${ranks}" var="team" varStatus="i">
                            <tr>
                                <td>${myrank[i.index]+1}</td>
                                <td>${team.account}</td>
                                <td>${team.memberToString()}</td>
                                <td>${team.solvedCount}</td>
                                <td>${team.calcSumPenalty()}</td>
                                <c:forEach begin="1" end="${contest.pbCnt}" var="j">
                                    <td>${team.pbStatus.get(j-1).toHString()}</td>
                                </c:forEach>
                                <%--<td>--%>
                                    <%--<c:if test="${team.member.contains(user.realName)}">--%>
                                        <%--<a href="<c:url value="/contest/contestDeleteTeam/${contest.id}/${i.index}"/> ">删除</a>--%>
                                    <%--</c:if>--%>
                                <%--</td>--%>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <jsp:include page="footerInfo.jsp"/>
</body>
</html>
