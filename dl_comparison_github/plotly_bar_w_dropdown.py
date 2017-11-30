import plotly

plotly.offline.init_notebook_mode()
trace_rep = plotly.graph_objs.Bar(x = dl_activities.repositories, y = dl_activities.keyword, name = "Repositories", orientation = 'h', marker = dict(color = 'rgba(0, 0, 255, 1)'))
trace_commits = plotly.graph_objs.Bar(x = dl_activities.commits, y = dl_activities.keyword, name = "Commits", orientation = 'h', marker = dict(color = 'rgba(255, 165, 0, 1)'))
trace_issues = plotly.graph_objs.Bar(x = dl_activities.issues, y = dl_activities.keyword, name = "Issues", orientation = 'h', marker = dict(color = 'rgba(0, 255, 0, 1)'))
trace_wikis = plotly.graph_objs.Bar(x = dl_activities.wikis, y = dl_activities.keyword, name = "Wikis", orientation = 'h', marker = dict(color = 'rgba(255, 0, 0, 1)'))
data = [trace_rep, trace_commits, trace_issues, trace_wikis]
updatemenus = list([
    dict(
        active = -1,
        pad = dict(r = 50, b = 20),
        buttons = list([
            dict(label = 'Repositories',
                 method = 'update',
                 args = [{'visible': [True, False, False, False]},
                         {'title': 'Repositories'}]),
            dict(label = 'Commits',
                 method = 'update',
                 args = [{'visible': [False, True, False, False]},
                         {'title': 'Commits'}]),
            dict(label = 'Issues',
                 method = 'update',
                 args = [{'visible': [False, False, True, False]},
                         {'title': 'Issues'}]),
            dict(label = 'Wikis',
                 method = 'update',
                 args = [{'visible': [False, False, False, True]},
                         {'title': 'Wikis'}])
            
        ])
    )
])
layout = dict(showlegend = False, updatemenus = updatemenus)
fig = dict(data = data, layout = layout)
plotly.offline.iplot(fig)