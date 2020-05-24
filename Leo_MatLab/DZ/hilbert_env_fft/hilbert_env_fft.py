import numpy as np
import matplotlib.pyplot as plt


def dft_chpeck(fx):
    # print('start dft...')
    fx = np.asarray(fx, dtype=complex)
    m = fx.shape[0]
    fu = fx.copy()
    for i in range(m):
        u = i
        tmp_sum = 0
        for j in range(m):
            x = j
            tmp = fx[x]*np.exp(-2j*np.pi*x*u*np.divide(1, m, dtype=complex))
            tmp_sum += tmp
        fu[u] = tmp_sum
    # print('success dft...')
    return fu


def fft_chpeck(fx):
    # print('start fft...')
    fx = np.asarray(fx, dtype=complex)
    m = fx.shape[0]
    min_div_size = 4
    if m % 2 != 0:
        raise ValueError("!!!the input size must be 2^n")
    if m <= min_div_size:
        return dft_chpeck(fx)
    else:
        fx_even = fft_chpeck(fx[::2])
        fx_odd = fft_chpeck(fx[1::2])
        w_ux_2k = np.exp(-2j * np.pi * np.arange(m) / m)
        f_u = fx_even + fx_odd * w_ux_2k[:m//2]
        f_u_plus_k = fx_even + fx_odd * w_ux_2k[m//2:]
        fu = np.concatenate([f_u, f_u_plus_k])
    # print('success fft...')
    return fu


def ifft_chpeck(fu):
    # print('start ifft...')
    fu = np.asarray(fu, dtype=complex)
    fu_conjugate = np.conjugate(fu)
    fx = fft_chpeck(fu_conjugate)
    fx = np.conjugate(fx)
    fx = fx / fu.shape[0]
    # print('success ifft...')
    return fx


def hilbert_chpeck(am_data):
    print('start hilbert transform...')
    n = len(am_data)
    am_data_fft = fft_chpeck(am_data)
    n_zero_out = n - n // 2 - 1
    am_data_fft[n // 2 + 1:] = [0] * n_zero_out
    am_data_fft[1:n // 2] = 2 * am_data_fft[1:n // 2]
    print('success hilbert transform...')
    return ifft_chpeck(am_data_fft)


def hilbert_env_create(am_data):
    print('start AM data envelope creation, used fft based algorithm...')
    analytic_signal = hilbert_chpeck(am_data)
    print('success AM data envelope creation...')
    return np.abs(analytic_signal)


def graph_create_fft(data, n, fs, dpi, width, height):
    print('start create fft graph...')
    freq_start = 0
    freq_end = fs
    ts = np.linspace(freq_start, freq_end, n)[: (n // 2)]
    data = (1 / n) * np.abs(data)[: (n // 2)]
    print('     plot elements number: %d' % n)
    print('     sample rate: %d' % fs)
    print('     graph freq range: [%d:%d]' % (freq_start, freq_end/2))
    print('     dpi: %d' % dpi)
    print('     width: %d' % width)
    print('     height: %d' % height)
    graph = plt.figure(dpi=dpi, figsize=(width / dpi, height / dpi))
    plt.plot(ts, data)
    plt.xlabel("Frequency")
    plt.ylabel("Amplitude")
    graph.show()
    print('success create fft graph...')


def graph_create(data, fs, dpi, width, height):
    print('start create graph...')
    n = len(data)
    time_start = 0
    time_end = n/fs
    ts = np.linspace(time_start, time_end, n)
    print('     plot elements number: %d' % n)
    print('     sample rate: %d' % fs)
    print('     graph time range: [%d:%.2f]' % (time_start, time_end))
    print('     dpi: %d' % dpi)
    print('     width: %d' % width)
    print('     height: %d' % height)
    graph = plt.figure(dpi=dpi, figsize=(width / dpi, height / dpi))
    plt.plot(ts, data)
    plt.xlabel("Time")
    plt.ylabel("Amplitude")
    graph.show()
    print('success create graph...')


def get_am_data(am_file_path):
    print('start AM data get from %s' % am_file_path)
    f = open(am_file_path, "r")
    am_data = f.read().strip().split()
    f.close()
    am_data = [round(float(i), 4) for i in am_data]
    print('success AM data get from %s' % am_file_path)
    return am_data


def input_am_spec():
    print('Enter program specs:')
    print('     Enter path to file with AM signal data:')
    am_file_path = input()
    print('     Enter sampling frequency:')
    am_fs = int(input())
    print('     Enter dpi:')
    am_dpi = int(input())
    print('     Enter width:')
    am_width = int(input())
    print('     Enter height:')
    am_height = int(input())
    # test defines
    # am_file_path = '../test_gen_AM_MatLab/test_file.txt'
    # am_fs = 40000
    # am_dpi = 100
    # am_width = 640
    # am_height = 360
    return am_file_path, am_fs, am_dpi, am_width, am_height


def main():
    print('Its program get data from txt AM signal file, double precision data in ASCII...')
    am_file_path, am_fs, am_dpi, am_width, am_height = input_am_spec()
    am_data = get_am_data(am_file_path)
    graph_create(am_data, am_fs, am_dpi, am_width, am_height)
    env_am_data = hilbert_env_create(am_data)
    graph_create(env_am_data, am_fs, am_dpi, am_width, am_height)
    graph_create_fft(fft_chpeck(env_am_data), len(env_am_data), am_fs, am_dpi, am_width, am_height)
    print('Press any key for close graphs & exit...')
    input()


if __name__ == '__main__':
    main()
