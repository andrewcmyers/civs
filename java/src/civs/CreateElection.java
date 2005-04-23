package civs;

import javax.servlet.ServletException;

import servlet.Br;
import servlet.CheckBox;
import servlet.Header;
import servlet.Input;
import servlet.Node;
import servlet.NodeList;
import servlet.Page;
import servlet.Paragraph;
import servlet.Radio;
import servlet.RadioButton;
import servlet.Request;
import servlet.Span;
import servlet.TCell;
import servlet.TRow;
import servlet.Table;
import servlet.Tag;
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
	final Input shuffle_checkbox = new CheckBox(main, true);
	final Input proportional_checkbox = new CheckBox(main, false);
	final Input report_ballots_checkbox = new CheckBox(main, false);
	Radio completion_method = new Radio(main);
	final Input bpw = new RadioButton(completion_method, "beatpath_winner", true);
	final Input crp = new RadioButton(completion_method, "civs_rp", false);
	final Input mam = new RadioButton(completion_method, "MAM", false);
	
	final FinishCreate finishCreate = new FinishCreate();
	
	public CreateElection(Main main) {
		super(main);
	}
	
	/* (non-Javadoc)
	 * @see servlet.Session#handle(servlet.Request)
	 */
	
	Node desc(String txt) {
		Tag n = new TCell(new Text(txt));
		n.setClass("desc");
		return n;
	}
	
	Node check_box_explained(Input b, String explanation) {
		return new TCell(new NodeList(b,
				new Span("tiny", new Text(explanation))));
	}
	Node typein_explained(Input b, String explanation) {
		return new TCell(new NodeList(b,
				new Br(),
				new Span("tiny", new Text(explanation))));
	}
												
	
	public Page invoke(Request req) throws ServletException {
		return main().createPage("CIVS Election Creation",
		  new NodeList(main().banner(),
		      new Header(2, "Create New Election"),
			  new Paragraph(new Text("You will be the supervisor of the election you create.")),
					main().createForm(finishCreate,
					  new Table(null,
					  		new NodeList(
					  		  new TRow(new NodeList(
						 		desc("Name of the election:"),
								typein_explained(title_inp, "e.g., The Democratic Primary"))),
							  new TRow(new NodeList(
							  	desc("Your name:"),
								typein_explained(name_inp,
										"This is used to identify you in e-mails sent to voters"))),
							  new TRow(new NodeList(
							  	desc("E-mail address:"),
								typein_explained(email_addr_inp,
										"This is needed to send you the election control information"))),
							  new TRow(new NodeList(
							  	desc("When you plan to stop the election:"),
						 		typein_explained(election_end_inp,
						 				"e.g., Friday at noon, April 5 at 5pm"))),
							  new TRow(new NodeList(
							  	desc("How many choices (candidates) will win:"),
								new TCell(num_choices_inp))),
							  new TRow(new NodeList(
							  	desc("Names of the choices:"),
								new TCell(choices_inp))),
							  new TRow(new NodeList(
							    desc("Public poll?"),
								check_box_explained(public_checkbox,
									"Voters can add themselves," +
								    " and there is only a token attempt to prevent multiple voting")))
							)
							.append(new TRow(new NodeList(
									desc("Allow write-ins?"),
									check_box_explained(writein_checkbox,
											"Voters can add new choices (candidates) and revise their votes"))))
							.append(new TRow(new NodeList(
							    desc("Shuffle choices?"),
								check_box_explained(shuffle_checkbox,
										"The order of the choices is randomly permuted on each ballot"))))
							.append(new TRow(new NodeList(
							  	desc("Proportional representation?"),
								check_box_explained(proportional_checkbox,
										"An experimental mode that only makes sense when there is more than one winner"))))
							.append(new TRow(new NodeList(
							  	desc("Anonymous ballot reporting?"),
								check_box_explained(report_ballots_checkbox,
										"Allow anyone to see the ballots cast, but with all personally identifying information removed."))))
							.append(new TRow(new NodeList(
								desc("Condorcet completion method:"),
								new TCell(new NodeList(bpw, new Text(" Beatpath Winner"),
										     crp, new Text(" CIVS Ranked Pairs"),
											 mam, new Text(" MAM"),
											 new NodeList(new Br(),											 
											 new Span("tiny",
											   new Text("Three different methods for resolving circular orderings. " +
											   		    "It usually doesn't matter which one is used because " +
														"circularities are uncommon."))
											 ))))))
									))));
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
