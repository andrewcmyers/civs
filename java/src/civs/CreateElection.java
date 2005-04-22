package civs;

import javax.servlet.ServletException;

import servlet.Br;
import servlet.CheckBox;
import servlet.Header;
import servlet.Input;
import servlet.NodeList;
import servlet.Page;
import servlet.Paragraph;
import servlet.Request;
import servlet.TCell;
import servlet.TRow;
import servlet.Table;
import servlet.Text;
import servlet.TextInput;
import servlet.TextArea;

public class CreateElection extends CIVSAction {
	final Input title_inp = new TextInput(main, 50, "");
	final Input name_inp = new TextInput(main, 20, "");
	final Input email_addr_inp = new TextInput(main, 20, "");
	final Input election_end_inp = new TextInput(main, 20, "tomorrow at 5pm");
	final Input choices_inp = new TextArea(main, 4, 60, "");
	final Input num_choices_inp = new TextInput(main, 3, "1");
	final Input public_checkbox = new CheckBox(main, false);
	final Input writein_checkbox = new CheckBox(main, false);
	
	final FinishCreate finishCreate = new FinishCreate();
	
	public CreateElection(Main main) {
		super(main);
	}
	
	/* (non-Javadoc)
	 * @see servlet.Session#handle(servlet.Request)
	 */
	public Page invoke(Request req) throws ServletException {
		return main().createPage("CIVS Election Creation",
		  new NodeList(main().banner(),
		      new Header(2, new Text("Create Election")),
			  new Paragraph(new Text("This web page allows you to create a new " +
			  		"web election. You will be the supervisor of " +
			  		"the election you create.")),
					main().createForm(finishCreate,
					  new Table(null,
					  		new NodeList(
					  		  new TRow(new NodeList(
						 		new TCell(new Text("Name of the election:")),
								new TCell(title_inp))),
							  new TRow(new NodeList(
							  	new TCell(new Text("Your name:")),
								new TCell(name_inp))),
							  new TRow(new NodeList(
							  	new TCell(new Text("Your email address:")),
								new TCell(email_addr_inp))),
							  new TRow(new NodeList(
							  	new TCell(new Text("Day and time you plan to stop the election:")),
						 		new TCell(election_end_inp))),
							  new TRow(new NodeList(
							  	new TCell(new Text("How many choices (candidates) will win the election:")),
								new TCell(num_choices_inp))),
							  new TRow(new NodeList(
							  	new TCell(new Text("Names of the choices:")),
								new TCell(choices_inp))),
							  new TRow(new NodeList(
							    new TCell(new Text("Make this a public poll (voters can add themselves," +
							  			  " and there is only a token attempt to prevent multiple voting")),
								new TCell(public_checkbox))))
							  .append(new TRow(new NodeList(
							  	new TCell(new Text("Allow voters to write in new choices and change their vote")),
								new TCell(writein_checkbox)))))
							)));
		}
	
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
					new Header(2, new Text("Test election creation")),
					new Text("Title = " + title),
					new Br(),
					new Text("Name = " + name),
					new Br(),
					new Text("Choices = " + req.getParam(choices_inp))));
		}
	}
}
