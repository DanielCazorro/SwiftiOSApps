//
//  StatisticsView.swift
//  Grocery List
//
//  Created by Daniel Cazorro on 16/08/2026.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    let statistics: GroceryStatistics

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    summary
                    progress
                    if !statistics.categoryCounts.isEmpty {
                        aisleBreakdown
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .overlay {
                if statistics.isEmpty {
                    ContentUnavailableView(
                        "Nothing to measure yet",
                        systemImage: "chart.bar",
                        description: Text("Add a few items and your progress will show up here.")
                    )
                }
            }
        }
    }

    // MARK: - Sections

    private var summary: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle("Summary")

            HStack(spacing: 12) {
                StatCard(title: "Total", value: statistics.totalItems, symbol: "cart", tint: .blue)
                StatCard(title: "Left", value: statistics.pendingItems, symbol: "clock", tint: .orange)
                StatCard(title: "Completed", value: statistics.completedItems, symbol: "checkmark.circle", tint: .green)
            }
        }
    }

    private var progress: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle("Progress")

            HStack(spacing: 20) {
                completionRing

                VStack(alignment: .leading, spacing: 6) {
                    Text("\(statistics.completedItems) of \(statistics.totalItems) done")
                        .font(.headline)

                    if statistics.highPriorityPending > 0 {
                        Label(
                            "\(statistics.highPriorityPending) high priority pending",
                            systemImage: "exclamationmark.circle.fill"
                        )
                        .font(.subheadline)
                        .foregroundStyle(.red)
                    } else if statistics.pendingItems == 0 {
                        Label("List complete", systemImage: "party.popper")
                            .font(.subheadline)
                            .foregroundStyle(.green)
                    } else {
                        Text("\(statistics.pendingItems) still to pick up")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding()
            .cardBackground()
        }
    }

    private var completionRing: some View {
        ZStack {
            Circle()
                .stroke(.quaternary, lineWidth: 12)

            Circle()
                .trim(from: 0, to: statistics.completionRate)
                .stroke(.green, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .rotationEffect(.degrees(-90))

            Text(statistics.completionRate, format: .percent.precision(.fractionLength(0)))
                .font(.headline)
                .monospacedDigit()
                .contentTransition(.numericText())
        }
        .frame(width: 84, height: 84)
        .animation(.snappy, value: statistics.completionRate)
        .accessibilityElement()
        .accessibilityLabel("Completion rate")
        .accessibilityValue(Text(statistics.completionRate, format: .percent.precision(.fractionLength(0))))
    }

    private var aisleBreakdown: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle("By aisle")

            Chart(statistics.categoryCounts) { entry in
                // Two marks on the same row stack into one bar: what is still
                // pending in the aisle colour, what is done washed out behind it.
                BarMark(
                    x: .value("Items", entry.pending),
                    y: .value("Aisle", String(localized: entry.category.name))
                )
                .foregroundStyle(entry.category.tint)

                BarMark(
                    x: .value("Items", entry.completed),
                    y: .value("Aisle", String(localized: entry.category.name))
                )
                .foregroundStyle(entry.category.tint.opacity(0.2))
                .annotation(position: .trailing, alignment: .leading, spacing: 6) {
                    Text(entry.total, format: .number)
                        .font(.caption.bold())
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 4))
            }
            .chartYAxis {
                AxisMarks(preset: .extended, position: .leading)
            }
            .chartLegend(.hidden)
            .chartXScale(domain: 0...(maxAisleTotal + 1))
            .frame(height: max(CGFloat(statistics.categoryCounts.count) * 34, 160))
            .padding()
            .cardBackground()
            .accessibilityLabel("Pending items by aisle")

            HStack(spacing: 16) {
                LegendSwatch(opacity: 1, label: "Pending")
                LegendSwatch(opacity: 0.2, label: "Completed")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }

    /// Leaves room on the right for the trailing value labels.
    private var maxAisleTotal: Int {
        statistics.categoryCounts.map(\.total).max() ?? 1
    }
}

// MARK: - Building blocks

private struct SectionTitle: View {
    let text: LocalizedStringKey

    init(_ text: LocalizedStringKey) { self.text = text }

    var body: some View {
        Text(text)
            .font(.title3.bold())
    }
}

private struct LegendSwatch: View {
    let opacity: Double
    let label: LocalizedStringKey

    var body: some View {
        HStack(spacing: 5) {
            RoundedRectangle(cornerRadius: 2)
                .fill(.secondary.opacity(opacity))
                .frame(width: 10, height: 10)
            Text(label)
        }
        .accessibilityElement(children: .combine)
    }
}

private struct StatCard: View {
    let title: LocalizedStringKey
    let value: Int
    let symbol: String
    let tint: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: symbol)
                .font(.title3)
                .foregroundStyle(tint)

            Text(value, format: .number)
                .font(.title.bold())
                .monospacedDigit()
                .contentTransition(.numericText())

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .cardBackground()
        .accessibilityElement(children: .combine)
    }
}

private extension View {
    /// Grouped-list card styling, consistent across every panel on this screen.
    func cardBackground() -> some View {
        background(Color(.secondarySystemGroupedBackground), in: .rect(cornerRadius: 14))
    }
}

// MARK: - Previews

#Preview("Mid-shop") {
    StatisticsView(
        statistics: GroceryStatistics(items: {
            let items = Item.sampleList()
            items.prefix(3).forEach { $0.toggleCompletion() }
            return items
        }())
    )
}

#Preview("Empty") {
    StatisticsView(statistics: GroceryStatistics(items: []))
}
