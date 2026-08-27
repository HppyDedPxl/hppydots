hl.config({{
    general = {{
        col = {{
            active_border = {{ colors = {{"rgba({color5.rgb},1)", "rgba({color4.rgb},1)"}}, angle = 45 }},
            inactive_border = "rgba({color1.rgb},1)"
        }}
        
    }},
    group = {{
        groupbar = {{
            col = {{
                active = "rgba({color5.rgb},1)",
                inactive = "rgba({color1.rgb},.7)"
            }}
        }},
        col = {{
           border_active = {{ colors = {{"rgba({color5.rgb},1)", "rgba({color4.rgb},1)"}}, angle = 45 }},
           border_inactive =  "rgba({color1.rgb},.7)"
        }}
    }},
    decoration = {{
        shadow = {{
            color = "rgb(24, 23, 24)"
        }}
    }}
}})