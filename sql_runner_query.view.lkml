
view: sql_runner_query {
  derived_table: {
    sql: SELECT page.pageTitle, COUNT(*) FROM `sandbox-analytics-386515.POC_GOOGLE_ANALYTICS.POC_GOOGLE_ANALYTICS` LEFT JOIN UNNEST(hits) as hits GROUP BY 1 ORDER BY 2 DESC LIMIT 100 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.pageTitle ;;
  }

  dimension: f0_ {
    type: number
    sql: ${TABLE}.f0_ ;;
  }

  set: detail {
    fields: [
        page_title,
	f0_
    ]
  }
}
