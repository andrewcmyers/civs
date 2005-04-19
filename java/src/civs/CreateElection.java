package civs;

import javax.servlet.ServletException;

import servlet.Br;
import servlet.Header;
import servlet.Input;
import servlet.NodeList;
import servlet.Page;
import servlet.Paragraph;
import servlet.Request;
import servlet.Text;
import servlet.TextInput;
import servlet.TextArea;

public class CreateElection extends CIVSAction {
	public CreateElection(Main main) {
		super(main);
	}
	
	/* (non-Javadoc)
	 * @see servlet.Session#handle(servlet.Request)
	 */
	public Page invoke(Request req) throws ServletException {
		final Input title_inp = new TextInput("title", 50, "");
		final Input name_inp = new TextInput("name", 20, "");
		final Input email_addr_inp = new TextInput("email_addr", 20, "");
		final Input election_end_inp = new TextInput("election_end", 20, "tomorrow at 5pm");
		final Input voters_inp = new TextArea("voters", 5, 64, "<enter voter email addresses here>");
		class FinishCreate extends CIVSAction {
			FinishCreate() {
				super(CreateElection.this.main);
			}
			public Page invoke(Request req) {
				String title = req.getParam(title_inp);
				String name = req.getParam(name_inp);
				String email_addr = req.getParam(email_addr_inp);
				String election_end = req.getParam(election_end_inp);
				
				return main.createPage("Test creation",
				   new NodeList(main().banner(),
						new Header(2, "Test election creation"),
						new Text("Title = " + title),
						new Br(),
						new Text("Name = " + name),
						new Br(),
						new Text("Voter addresses = " + req.getParam(voters_inp))));
			}
		}
		return main().createPage("CIVS Election Creation",
		  new NodeList(main().banner(),
		      new Header(2, "Create Election"),
			  new Paragraph(new Text("This web page allows you to create a new " +
			  		"web election. You will be the supervisor of " +
			  		"the election you create.")),
					main().createForm(new FinishCreate(),
				      new NodeList(
						 new NodeList(
						 		new Text("Name of the election: "), title_inp, new Br()),
						 new NodeList(
						 		new Text("Your name: "),	name_inp, new Br()),
						 new NodeList(
						 		new Text("Your email address: "), email_addr_inp, new Br()),						   		
						 new NodeList(new Text("Day and time you plan to stop the election: "),
						 		election_end_inp, new Br()),
					     new NodeList(new Text("Email addresses of voters"), voters_inp)	
							))));

	}
	

}
