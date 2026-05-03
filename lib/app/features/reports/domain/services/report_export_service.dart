import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../entities/adherence_report_entity.dart';
import '../entities/missed_dose_entity.dart';

class ReportExportService {
  Future<void> exportAndShareReport({
    required AdherenceReportEntity adherenceReport,
    required List<MissedDoseEntity> missedDoses,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            _buildHeader(adherenceReport),
            pw.SizedBox(height: 20),
            _buildSummarySection(adherenceReport),
            pw.SizedBox(height: 20),
            _buildMissedDosesSection(missedDoses),
          ];
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'med_track_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  pw.Widget _buildHeader(AdherenceReportEntity report) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Medication Adherence Report',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'Period: ${report.period.toUpperCase()}',
          style: const pw.TextStyle(fontSize: 14),
        ),
        pw.Text(
          'Generated on: ${DateFormat('MMM d, yyyy').format(DateTime.now())}',
          style: const pw.TextStyle(fontSize: 14),
        ),
        pw.Divider(thickness: 2),
      ],
    );
  }

  pw.Widget _buildSummarySection(AdherenceReportEntity report) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Summary statistics',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Adherence Rate', '${report.overallAdherencePercentage.toInt()}%'),
            _buildStatItem('Doses Taken', '${report.totalTaken}'),
            _buildStatItem('Total Scheduled', '${report.totalScheduled}'),
            _buildStatItem('Missed Doses', '${report.totalMissed}'),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildStatItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(label, style: const pw.TextStyle(fontSize: 12)),
        pw.Text(value, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _buildMissedDosesSection(List<MissedDoseEntity> doses) {
    if (doses.isEmpty) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Missed Doses',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Text('No missed doses recorded for this period.'),
        ],
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Missed Doses History',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        pw.TableHelper.fromTextArray(
          headers: ['Date', 'Time', 'Medicine Name'],
          data: doses.map((dose) {
            return [
              DateFormat('MMM d, yyyy').format(dose.scheduledTime),
              DateFormat('h:mm a').format(dose.scheduledTime),
              dose.medicineName,
            ];
          }).toList(),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          cellAlignment: pw.Alignment.centerLeft,
        ),
      ],
    );
  }

  Future<void> shareTextReport(AdherenceReportEntity report) async {
    final text = '''
Medication Adherence Report
Period: ${report.period.toUpperCase()}
Overall Adherence: ${report.overallAdherencePercentage.toInt()}%
Doses Taken: ${report.totalTaken}/${report.totalScheduled}
Total Missed: ${report.totalMissed}
''';

    await Share.share(text, subject: 'My Medication Report');
  }
}
