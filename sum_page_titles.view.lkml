
view: sum_page_titles {
  derived_table: {
    sql: SELECT page.pageTitle, COUNT(*) as page_title_sum FROM `sandbox-analytics-386515.POC_GOOGLE_ANALYTICS.POC_GOOGLE_ANALYTICS` LEFT JOIN UNNEST(hits) as hits GROUP BY 1 ORDER BY 2 DESC LIMIT 100 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.pageTitle ;;
  }

  dimension: page_title_sum {
    type: number
    sql: ${TABLE}.page_title_sum ;;
  }

  set: detail {
    fields: [
        page_title,
	page_title_sum
    ]
  }
}
