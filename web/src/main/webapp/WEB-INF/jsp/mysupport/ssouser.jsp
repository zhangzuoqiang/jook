<img src="${pageContext.request.contextPath }/mysupportresources/images/${incident.ssoUserId != null ? "approved" : "declined" }.png"/>
<p>${incident.ssoUserId != null ? incident.ssoUserId : "Not Available" }</p>