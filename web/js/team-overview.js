const initial = 1737361436;
const localInitial = new Date().getTime();
let activatetime = 0;
let starttime = 0;
let endtime = 0;
const clientOffset = localInitial - new Date(initial * 1000).getTime();
const timeleftelt = document.getElementById("timeleft");
const progress = document.getElementById("contest-progress");

let currentContestId = getCookie("CONTESTID");
if (currentContestId !== null)
{
	setCookie("CONTESTID", 1);
	currentContestId = 1;
}

const requestContest = new XMLHttpRequest();
requestContest.open("GET", "/api/contest/" + currentContestId, true);
requestContest.send();
requestContest.onreadystatechange = function ()
{
	if (this.readyState === 4 && this.status === 200)
	{
		function formatTime(time, sec)
		{
			const date = new Date(time * 1000);
			const hours = date.getHours();
			const minutes = date.getMinutes();
			const seconds = date.getSeconds();
			let value = "";
			if (hours < 10) value += "0";
			value += hours;
			value += ":";
			if (minutes < 10) value += "0";
			value += minutes;
			if (sec)
			{
				value += ":";
				if (seconds < 10) value += "0";
				value += seconds;
			}
			return value;
		}
		const contest = JSON.parse(this.responseText);
		const contestName = contest.NAME;
		activatetime = contest.ACTIVE;
		starttime = contest.START;
		endtime = contest.END;
		const navbarDropdownContests = document.getElementById("navbarDropdownContests");
		navbarDropdownContests.innerHTML += contestName;
		const contestTimer = document.getElementById("contesttimer");
		// started: 00:00 - ends: 00:00
		if (contestTimer)
		{
			contestTimer.innerHTML = "started: " +
				formatTime(starttime) +
				" - ends: " +
				formatTime(endtime);
		}
		setInterval(function ()
		{
			updateClock();
		}, 1000);
		updateClock();
		const scoreheader = document.getElementById("scoreheader");
		if (scoreheader)
		{
			function formatColor(rgb)
			{
				let val = "";
				for (let i = 0; i < 6; i++)
				{
					val = "0123456789ABCDEF"[(rgb % 16)] + val;
					rgb = ((rgb - (rgb % 16)) / 16);
				}
				return val;
			}
			for (let i = 0; i < contest.PROBLEM.length; i++)
			{
				const cproblem = contest.PROBLEM[i];
				scoreheader.innerHTML += "<th title=\"problem " +
					cproblem.NAME +
					"\" scope=\"col\" style=\"top: 56px;\">\n" +
					"<a href=\"/public/problem/" +
					cproblem.PID +
					"\" target=\"_self\">\n" +
					"<span class=\"badge problem-badge\" style=\"background-color: #" +
					formatColor(cproblem.COLOR) +
					";border: 1px solid #bfbfbf\">\n" +
					"<span style=\"color: #000000;\">"+
					String.fromCharCode(65 + i)+
					"</span>\n" +
					"</span>\n" +
					"</a>\n" +
					"</th>";
			}
		}
	}
}

const requestContests = new XMLHttpRequest();
requestContests.open("GET", "/api/contests", true);
requestContests.send();
requestContests.onreadystatechange = function ()
{
	if (this.readyState === 4 && this.status === 200)
	{
		const contests = JSON.parse(this.responseText);
		const contestSelect = document.getElementById("change-contest");
		for (let i = 0; i < contests.length; i++)
		{
			const contest = contests[i];
			if (contest.ID !== currentContestId)
			{
				const contestId = contest.ID;
				const contestName = contest.NAME;
				contestSelect.innerHTML += "<a class=\"dropdown-item\" href=\"/team/change-contest/" +
					contestId +
					"\">" + contestName + "</a>";
			}
		}
	}
}