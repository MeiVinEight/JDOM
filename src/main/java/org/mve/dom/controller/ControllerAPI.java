package org.mve.dom.controller;

import org.mve.dom.pojo.*;
import org.mve.mapper.SimpleMapper;
import org.mve.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.sql.DataSource;
import java.util.List;

@ResponseBody
@Controller("API")
@RequestMapping("/api")
public class ControllerAPI
{
	private final SimpleMapper<Submission> submission;
	private final SimpleMapper<Team> team;
	private final SimpleMapper<Country> country;
	private final SimpleMapper<Contest> contest;
	private final SimpleMapper<CPROBLEM> cproblem;

	public ControllerAPI(DataSource source)
	{
		this.submission = new SimpleMapper<>(Submission.class, source);
		this.team = new SimpleMapper<>(Team.class, source);
		this.country = new SimpleMapper<>(Country.class, source);
		this.contest = new SimpleMapper<>(Contest.class, source);
		this.cproblem = new SimpleMapper<>(CPROBLEM.class, source);
	}

	@RequestMapping("/submissions/{id}")
	public Submission submission(@PathVariable long id)
	{
		return this.submission.primary(id);
	}

	@GetMapping("/team/{id}")
	public Team team(@PathVariable long id)
	{
		Team team = this.team.primary(id);
		if (team == null) team = new Team();
		return team;
	}

	@GetMapping("/country/{code:^[a-z]{2}$|^[A-Z]{2}$}")
	public Country country(@PathVariable String code)
	{
		code = code.toUpperCase();
		Country country = new Country();
		country.CODE2 = code;
		List<Country> countries = this.country.select(new Query().eq("CODE2", code));
		if (!countries.isEmpty()) country = countries.get(0);
		if (country == null) country = new Country();
		return country;
	}

	@GetMapping("/contest/{id}")
	public Contest contest(@PathVariable int id)
	{
		Contest contest = this.contest.primary(id);
		if (contest == null) contest = new Contest();
		else
		{
			List<CPROBLEM> problems = this.cproblem.select(new Query()
				.eq("CID", id));
			contest.PROBLEM = new CPROBLEM[problems.size()];
			for (CPROBLEM problem : problems)
			{
				contest.PROBLEM[problem.IDX - 1] = problem;
			}
		}
		return contest;
	}

	@GetMapping("/contests")
	public List<Contest> contests()
	{
		Query query = new Query();
		return this.contest.select(query);
	}
}
/*
<th title="problem AAA" scope="col" style="top: 56px;">
	<a target="_self">
		<span class="badge problem-badge" style="background-color: #ff0000;border: 1px solid #bfbfbf">
			<span style="color: #000000;">A</span>
		</span>
	</a>
</th>
*/