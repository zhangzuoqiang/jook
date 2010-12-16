package com.railinc.jook.web.interactions;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.railinc.jook.Jook;
import com.railinc.jook.domain.Downtime;
import com.railinc.jook.domain.NewsItem;
import com.railinc.jook.service.NewsService;

/**
 * Servlet implementation class DowntimeServlet
 */
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WebApplicationContext context;
	private NewsService downtimeService;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String app = request.getParameter(Jook.JOOK_PARAM_APP);
		
			response.setContentType("text/html");
			
			StringBuilder sb = new StringBuilder("<style>\n");
			sb.append("#news  { text-align:left; }\n");
			sb.append("#news h1 {text-align:left;border-bottom:1px solid gray;margin-bottom:10px;}\n");
					sb.append("#news div h2 {font-size:10pt;font-weight:bold;}\n");
							sb.append("#news div p {font-size:8pt;}\n");
									sb.append("</style>\n");
			
									
			PrintWriter writer = response.getWriter();
			writer.write(sb.toString());
			List<NewsItem> ds = downtimeService.showNews(app);
			writer.write("<div id='news'>");
			
			for (NewsItem d : ds) {
				writer.write("<div>");
				writer.write("<h2>");
				writer.write(d.getTitle());
				writer.write("</h2>");
				
				writer.write(d.getDescription());
				writer.write("<p>");
				writer.write("</p>");
				writer.write("</div>");
			}
			writer.write("</div>");			
		
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		context = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
		Map beans = context.getBeansOfType(NewsService.class);
		this.downtimeService = (NewsService) (beans.values().iterator().hasNext() ? beans.values().iterator().next() : null);
	}

}