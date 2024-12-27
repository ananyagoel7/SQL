
-- Total Seats--
Select distinct count(Parliament_Constituency) as Total_Seats from constituencywise_results;

-- What is the total number of seats available for elections in each state --
select s.State as State_Name, count(cr.Constituency_ID) as Total_Seats_Available from constituencywise_results cr join
statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency join states s on sr.State_ID = 
s.State_ID group by s.State order by s.State;

-- Total Seats Won by NDA Allianz--
Select sum(case when party in (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') then [Won] else 0 end) as NDA_Total_Seats_Won from partywise_results;

-- Seats Won by NDA Allianz Parties--
Select party as Party_Name, won as Seats_Won from partywise_results where party in (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
		'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
		'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM') ORDER BY Seats_Won DESC;
        
-- Total Seats Won by I.N.D.I.A. Allianz--
select sum(case when party in('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK') then [Won] else 0 end) AS INDIA_Total_Seats_Won from partywise_results;

-- Seats Won by I.N.D.I.A. Allianz Parties--
select party as Party_Name, won as Seats_Won from partywise_results where party in (
        'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')order by Seats_Won desc;

-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
select p.party_alliance, count(cr.Constituency_ID) as Seats_Won from constituencywise_results cr join
partywise_results p on cr.Party_ID = p.Party_ID where p.party_alliance in ('NDA', 'I.N.D.I.A', 'OTHER') group by 
p.party_alliance order by Seats_Won desc;

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
select cr.Winning_Candidate, p.Party, p.party_alliance, cr.Total_Votes, cr.Margin, cr.Constituency_Name, s.State
fromconstituencywise_results cr join partywise_results p on cr.Party_ID = p.Party_ID join statewise_results sr on
cr.Parliament_Constituency = sr.Parliament_Constituency join states s on sr.State_ID = s.State_ID where 
s.State = 'Uttar Pradesh' and cr.Constituency_Name = 'AMETHI';

-- What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
select cd.Candidate, cd.Party, cd.EVM_Votes, cd.Postal_Votes, cd.Total_Votes, cr.Constituency_Name from
constituencywise_details cd join nstituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID where 
cr.Constituency_Name = 'MATHURA' order by cd.Total_Votes desc;

-- Which parties won the most seats in s State, and how many seats did each party win?
select p.Party, COUNT(cr.Constituency_ID) as Seats_Won from constituencywise_results cr join partywise_results p on 
cr.Party_ID = p.Party_ID join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s on sr.State_ID = s.State_ID where s.state = 'Andhra Pradesh' group by p.Party order by Seats_Won desc;







