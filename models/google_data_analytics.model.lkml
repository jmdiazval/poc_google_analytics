connection: "poc_google_analytics"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: google_data_analytics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: google_data_analytics_default_datagroup

explore: poc_google_analytics {
    join: poc_google_analytics__hits {
      view_label: "Poc Google Analytics: Hits"
      sql: LEFT JOIN UNNEST(${poc_google_analytics.hits}) as poc_google_analytics__hits ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__custom_dimensions {
      view_label: "Poc Google Analytics: Customdimensions"
      sql: LEFT JOIN UNNEST(${poc_google_analytics.custom_dimensions}) as poc_google_analytics__custom_dimensions ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__hits__product {
      view_label: "Poc Google Analytics: Hits Product"
      sql: LEFT JOIN UNNEST(${poc_google_analytics__hits.product}) as poc_google_analytics__hits__product ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__hits__promotion {
      view_label: "Poc Google Analytics: Hits Promotion"
      sql: LEFT JOIN UNNEST(${poc_google_analytics__hits.promotion}) as poc_google_analytics__hits__promotion ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__hits__custom_metrics {
      view_label: "Poc Google Analytics: Hits Custommetrics"
      sql: LEFT JOIN UNNEST(${poc_google_analytics__hits.custom_metrics}) as poc_google_analytics__hits__custom_metrics ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__hits__custom_variables {
      view_label: "Poc Google Analytics: Hits Customvariables"
      sql: LEFT JOIN UNNEST(${poc_google_analytics__hits.custom_variables}) as poc_google_analytics__hits__custom_variables ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__hits__custom_dimensions {
      view_label: "Poc Google Analytics: Hits Customdimensions"
      sql: LEFT JOIN UNNEST(${poc_google_analytics__hits.custom_dimensions}) as poc_google_analytics__hits__custom_dimensions ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__hits__experiment {
      view_label: "Poc Google Analytics: Hits Experiment"
      sql: LEFT JOIN UNNEST(${poc_google_analytics__hits.experiment}) as poc_google_analytics__hits__experiment ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__hits__publisher_infos {
      view_label: "Poc Google Analytics: Hits Publisher Infos"
      sql: LEFT JOIN UNNEST(${poc_google_analytics__hits.publisher_infos}) as poc_google_analytics__hits__publisher_infos ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__hits__product__custom_metrics {
      view_label: "Poc Google Analytics: Hits Product Custommetrics"
      sql: LEFT JOIN UNNEST(${poc_google_analytics__hits__product.custom_metrics}) as poc_google_analytics__hits__product__custom_metrics ;;
      relationship: one_to_many
    }
    join: poc_google_analytics__hits__product__custom_dimensions {
      view_label: "Poc Google Analytics: Hits Product Customdimensions"
      sql: LEFT JOIN UNNEST(${poc_google_analytics__hits__product.custom_dimensions}) as poc_google_analytics__hits__product__custom_dimensions ;;
      relationship: one_to_many
    }
}

view: sql_runner_query {
  derived_table: {
    sql: SELECT page.pageTitle, COUNT(*) as count
         FROM `sandbox-analytics-386515.POC_GOOGLE_ANALYTICS.POC_GOOGLE_ANALYTICS`
         LEFT JOIN UNNEST(hits) as hits
         GROUP BY 1
         ORDER BY 2 DESC
         LIMIT 100 ;;
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.pageTitle ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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
