import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/device.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/api/auth_api.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/app_button.dart';

class DeviceManagementScreen extends ConsumerStatefulWidget {
  const DeviceManagementScreen({super.key});

  @override
  ConsumerState<DeviceManagementScreen> createState() =>
      _DeviceManagementScreenState();
}

class _DeviceManagementScreenState
    extends ConsumerState<DeviceManagementScreen> {
  late Future<List<DeviceInfo>> _devicesFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  void _loadDevices() {
    final authApiService = ref.read(authApiServiceProvider);
    _devicesFuture = authApiService.getUserDevices();
  }

  Future<void> _removeDevice(String deviceId) async {
    setState(() => _isLoading = true);
    try {
      final authApiService = ref.read(authApiServiceProvider);
      await authApiService.removeDevice(deviceId);
      _loadDevices();
      setState(() {});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Device removed successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to remove device: $e')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateDeviceName(String deviceId, String newName) async {
    setState(() => _isLoading = true);
    try {
      final authApiService = ref.read(authApiServiceProvider);
      await authApiService.updateDeviceName(
        deviceId: deviceId,
        deviceName: newName,
      );
      _loadDevices();
      setState(() {});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Device name updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update device name: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Device Management',
          style: AppTextStyles.headlineMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Manage Your Devices',
                style: AppTextStyles.displaySmall.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppDimensions.space2),
              Text(
                'You can have up to 3 devices registered. Remove unused devices to free up space.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppDimensions.space6),

              // Device limit info
              _buildDeviceLimitInfo(),
              const SizedBox(height: AppDimensions.space6),

              // Devices list
              Expanded(
                child: FutureBuilder<List<DeviceInfo>>(
                  future: _devicesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 64),
                            const SizedBox(height: AppDimensions.space4),
                            Text(
                              'Failed to load devices',
                              style: AppTextStyles.headlineSmall,
                            ),
                            const SizedBox(height: AppDimensions.space2),
                            Text(
                              snapshot.error.toString(),
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium,
                            ),
                            const SizedBox(height: AppDimensions.space4),
                            AppButton(
                              text: 'Retry',
                              onPressed: () {
                                _loadDevices();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      );
                    }

                    final devices = snapshot.data ?? [];
                    if (devices.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.devices_other,
                              size: 64,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: AppDimensions.space4),
                            Text(
                              'No devices registered',
                              style: AppTextStyles.headlineSmall,
                            ),
                            const SizedBox(height: AppDimensions.space2),
                            Text(
                              'Your current device will be registered automatically',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        final device = devices[index];
                        return _buildDeviceCard(device);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceLimitInfo() {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.space4),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.info, size: 24),
            const SizedBox(width: AppDimensions.space3),
            Expanded(
              child: Text(
                'Device Limit: 3 devices maximum',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(DeviceInfo device) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.space3),
      child: AppCard(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Device header
              Row(
                children: [
                  Icon(
                    device.isCurrentDevice
                        ? Icons.smartphone
                        : Icons.devices_other,
                    color: device.isCurrentDevice
                        ? AppColors.primary700
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
                  const SizedBox(width: AppDimensions.space3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.deviceName.isNotEmpty
                              ? device.deviceName
                              : device.deviceType,
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (device.isCurrentDevice)
                          Text(
                            'Current Device',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary700,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!device.isCurrentDevice)
                    IconButton(
                      onPressed: _isLoading
                          ? null
                          : () => _showRemoveDeviceDialog(device),
                      icon: const Icon(Icons.delete_outline),
                      color: AppColors.error,
                    ),
                ],
              ),

              const SizedBox(height: AppDimensions.space3),

              // Device details
              _buildDeviceDetail('Platform', device.platform),
              _buildDeviceDetail(
                'First Login',
                _formatDate(device.firstLoginAt),
              ),
              _buildDeviceDetail('Last Login', _formatDate(device.lastLoginAt)),
              _buildDeviceDetail(
                'Status',
                device.isActive ? 'Active' : 'Inactive',
              ),

              const SizedBox(height: AppDimensions.space4),

              // Actions
              ...(device.isCurrentDevice
                  ? []
                  : [
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              text: 'Rename',
                              type: ButtonType.outline,
                              onPressed: _isLoading
                                  ? null
                                  : () => _showRenameDialog(device),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.space3),
                          Expanded(
                            child: AppButton(
                              text: 'Remove',
                              type: ButtonType.outline,
                              onPressed: _isLoading
                                  ? null
                                  : () => _showRemoveDeviceDialog(device),
                            ),
                          ),
                        ],
                      ),
                    ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space2),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showRemoveDeviceDialog(DeviceInfo device) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Device', style: AppTextStyles.headlineSmall),
        content: Text(
          'Are you sure you want to remove "${device.deviceName.isNotEmpty ? device.deviceName : device.deviceType}"? This action cannot be undone.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelLarge.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _removeDevice(device.id);
            },
            child: Text(
              'Remove',
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showRenameDialog(DeviceInfo device) {
    final controller = TextEditingController(text: device.deviceName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rename Device', style: AppTextStyles.headlineSmall),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Device Name',
            hintText: 'Enter a name for this device',
          ),
          maxLength: 50,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelLarge.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                Navigator.of(context).pop();
                _updateDeviceName(device.id, newName);
              }
            },
            child: Text(
              'Save',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
