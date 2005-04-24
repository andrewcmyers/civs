package civs;

import javax.servlet.ServletException;

import servlet.*;

public class CreateElection extends CIVSAction {
	final InputNode title_inp = new TextInput(main, 50, "");
	final InputNode name_inp = new TextInput(main, 20, "");
	final InputNode email_addr_inp = new TextInput(main, 20, "");
	final InputNode election_end_inp = new TextInput(main, 20, "tomorrow at 5pm");
	final InputNode choices_inp = new TextArea(main, 4, 60, "");
	final InputNode num_choices_inp = new TextInput(main, 3, "1");
	final CheckBox public_checkbox = new CheckBox(main, false);
	final CheckBox writein_checkbox = new CheckBox(main, false);
	final CheckBox shuffle_checkbox = new CheckBox(main, true);
	final CheckBox proportional_checkbox = new CheckBox(main, false);
	final CheckBox report_ballots_checkbox = new CheckBox(main, false);
	Input completion_method = new Input(main);
	final InputNode bpw = new RadioButton(completion_method, "beatpath_winner", true);
	final InputNode crp = new RadioButton(completion_method, "civs_rp", false);
	final InputNode mam = new RadioButton(completion_method, "MAM", false);
	final InputNode names_chooser = new FileChooser(main);
	
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
	
	Node check_box_explained(InputNode b, String explanation) {
		return new TCell(new NodeList(b,
				new Span("tiny", new Text(explanation))));
	}
	Node typein_explained(InputNode b, String explanation) {
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
										"This is used to identify you in e-mails sent to voters."))),
							  new TRow(new NodeList(
							  	desc("E-mail address:"),
								typein_explained(email_addr_inp,
										"This is needed to send you the election control information." +
										"If you have a spam service filtering your mail, make sure that " +
										"it will not block mail from " + main.supervisor()))),
							  new TRow(new NodeList(
							  	desc("When you plan to stop the election:"),
						 		typein_explained(election_end_inp,
						 				"e.g., Friday at noon, April 5 at 5pm"))),
							  new TRow(new NodeList(
							  	desc("Number of winners:"),
								typein_explained(num_choices_inp,
										"Any number of choices (candidates) may win the election."))),
							  new TRow(new NodeList(
							  	desc("Names of the choices:"),
								new TCell(choices_inp))),
							  new TRow(new NodeList(
								desc("Or upload choice names:"),
								new TCell(names_chooser))))
							.append(new TRow(new NodeList(
							    desc("Public poll?"),
								check_box_explained(public_checkbox,
									"Voters can add themselves," +
								    " and there is only a token attempt to prevent multiple voting"))))
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
			// parse the request.
			
			Election election = new Election();
			election.id = "E_" + main.generateNonce();
			election.allow_writeins = writein_checkbox.isChecked(req);
			election.title = req.getParam(title_inp);
			election.name = req.getParam(name_inp);
			election.email = req.getParam(email_addr_inp);
			election.ends = req.getParam(election_end_inp);
			election.proportional = proportional_checkbox.isChecked(req);
			election.shuffle = shuffle_checkbox.isChecked(req);
			election.report_ballots = report_ballots_checkbox.isChecked(req);
			
			// install once we've successfully set everything up and sent mail.
			main.elections.put(election.id, election);
			
			return main.createPage("Election creation successful",
			   new NodeList(main().banner(),
					new Header(2, new Text("Test election creation")),
					new Text("Title = " + election.title),
					new Br(),
					new Text("Name = " + election.name),
					new Br(),
					new Text("Choices = " + req.getParam(choices_inp))));
		}
	}
}
