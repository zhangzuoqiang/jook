<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>

<%@page import="java.net.URLEncoder"%><jsp:useBean id="currentDate"
	class="java.util.Date" scope="request" />
<span id="moduleContentIdentifier" class="interactions"></span>
<form:form method="post" action="update" modelAttribute="interaction">

	<form:hidden path="id"/>




	<form:errors path="*" element="div" cssClass="noticeBox noticeError" />
	<h1><spring:message code="interactions.form.pagetitle" /></h1>
	<table>
		<tr>
			<td><form:label path="type">
				<spring:message code="interactions.fields.type" />
				<spring:message code="support.field.separator" />
			</form:label></td>
			<td><form:select path="type" items="${availableTypes }"></form:select></td>
		</tr>
		<tr>
			<td><form:label path="title">
				<spring:message code="interactions.fields.title" />
				<spring:message code="support.field.separator" />
			</form:label></td>
			<td><form:input path="title" cssErrorClass="noticeError" /></td>
		</tr>

		<tr>
			<td><form:label path="url">
				<spring:message code="interactions.fields.url" />
				<spring:message code="support.field.separator" />
			</form:label></td>
			<td><form:input size="30" path="url" cssErrorClass="noticeError" /></td>
			<td>Available Parameters - %app%, %ssoUser%</td>
		</tr>
			
		<tr>
			<td><form:label path="applications">
				<spring:message code="interactions.fields.apps" />
				<spring:message code="support.field.separator" />
			</form:label></td>
			<td><form:label path="excludeApplications">
				<spring:message code="interactions.fields.excludeApplications" />
			</form:label><form:checkbox id="excludeApplications" path="excludeApplications" cssErrorClass="noticeError" /> 
			
			<form:input id="applications" path="applications" cssErrorClass="noticeError" /></td>
			<td><spring:message code="interactions.fields.apps.whatisit" /></td>
		</tr>
		<tr>
			<td>
				</td>
			<td><form:label path="active">
				<spring:message code="interactions.fields.active" />
			</form:label><form:checkbox id="active" path="active" cssErrorClass="noticeError" />
			</td>
			<td><spring:message code="interactions.fields.active.whatisit" /></td>
		</tr>
		<tr>
			<td></td>
			<td><form:label path="secured">
				<spring:message code="interactions.fields.secured" />
				</form:label>
				<form:checkbox id="secured" path="secured" cssErrorClass="noticeError" />
			</td>
			<td><spring:message code="interactions.fields.secured.whatisit" /></td>
		</tr>


	</table>
	<app:buttonbar />
</form:form>
<script>
var availableTags = [
                 <c:forEach items="${ applications}" var="a" varStatus="s">
                 	<c:if test="${!s.first }">,</c:if>"${a }"
                 </c:forEach>
                 ];

jQuery(function() {
	function split( val ) {
		return val.split( /,\s*/ );
	}
	function extractLast( term ) {
		return split( term ).pop();
	}

	jQuery( "#applications" ).autocomplete({
		source: function( request, response ) {
			$.getJSON( "/jook/main/secure/refdata/applications", {
				term: extractLast( request.term )
			}, response );
		},
		focus: function() {
			// prevent value inserted on focus
			return false;
		},
		select: function( event, ui ) {
			var terms = split( this.value );
			// remove the current input
			terms.pop();
			// add the selected item
			terms.push( ui.item.value );
			// add placeholder to get the comma-and-space at the end
			//terms.push( "" );
			this.value = terms.join( ", " );
			return false;
		}
	});	
	
	jQuery("#excludeApplications").button({icons: {primary:'ui-icon-check'}});
	jQuery("#active").button({icons: {primary:'ui-icon-check'}});
	jQuery("#secured").button({icons: {primary:'ui-icon-check'}});
	});

</script>